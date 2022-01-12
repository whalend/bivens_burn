#' ---	
#' title: "Interacting global change drivers suppress a foundation tree species"	
#' author: "S.L. Flory, W.W. Dillon, D. Hiatt"	
#' date: "`r Sys.Date()`"	
#' output: 	
#'   github_document:	
#'     toc: yes	
#' ---	
#' 	
#' # Abstract 	
#' Ecological stress caused by climate change, invasive species, anthropogenic disturbance, and other factors is driving global environmental change. These stressors often occur simultaneously but how they interact to impact native species is poorly understood. We used a longer-term (i.e., six years) field experiment to test how two stressors (drought and invasion by the non-native perennial grass *Imperata cylindrica*) interacted to determine effects of a third stressor (fire) on longleaf pine (*Pinus palustris*), the foundation species for a threatened fire-dependent ecosystem in the Southeast USA. Invasion resulted in 65% greater fuel loads, causing over four times taller flames, significantly greater maximum temperatures, and longer heating duration. Invasion combined with prolonged drought also resulted in notably shorter trees than invasion alone, and shorter trees are substantially more vulnerable to mortality due to fire. Consequently, nearly all tree mortality occurred due to a synergistic interaction between fire and the drought + invasion treatment, whereby shorter trees experienced taller flames driven by invasion, resulting in 44% of trees killed by fire. Given average fuel loads in the experiment, modeling predicted that 99% of 2 m tall trees would survive in native vegetation-dominated areas but only 37% of 2 m tall trees would survive in invaded areas due to more intense fires, highlighting an ecosystem-wide benefit of invader prevention and removal. These findings demonstrate that synergy among ecological stressors can result in dramatic impacts on native species, emphasizing that longer-term, multi-factorial, manipulative studies are needed to accurately forecast ecological outcomes of global environmental change.	
#' 	
#' 	
knitr::opts_chunk$set(echo = F)	
knitr::opts_chunk$set(warning = F)	
knitr::opts_chunk$set(message = F)	
#' 	
#' 	
#' 	
#' 	
library(tidyverse)	
library(readxl)	
library(patchwork)	
require(lme4)	
require(MuMIn)	
require(DHARMa)	
require(sjPlot)	
require(broom)	
require(car)	
require(knitr)	
#' 	
#' 	
#' 	
treatment_color <- scale_color_manual(values = c("Reference" = "deepskyblue", "Drought" = "deepskyblue", "Invasion" = "red", "Drought + Invasion" = "red"))	
trt_col <- scale_color_manual(values = c("Reference" = "deepskyblue", "Drought" = "deepskyblue", "Invasion" = "red", "Dro + Inv" = "red"))	
	
treatment_fill <- scale_fill_manual(values = c("Reference" = "deepskyblue", "Drought" = "deepskyblue", "Invasion" = "red", "Drought + Invasion" = "red"))	
trt_fill <- scale_fill_manual(values = c("Reference" = "deepskyblue", "Drought" = "deepskyblue", "Invasion" = "red", "Dro + Inv" = "red"))	
	
treatment_shape <- scale_shape_manual(values = c("Reference" = 22, "Drought" = 24, "Invasion" = 21, "Drought + Invasion" = 23))	
trt_shp <- scale_shape_manual(values = c("Reference" = 22, "Drought" = 24, "Invasion" = 21, "Dro + Inv" = 23))	
	
treatment_lines <- scale_linetype_manual(values = c("Reference" = 1, "Drought" = 2, "Invasion" = 3, "Drought + Invasion" = 4))	
	
invasion_color <- scale_color_manual(values = c("Reference" = "deepskyblue", "Invasion" = "red"))	
invasion_fill <- scale_fill_manual(values = c("Reference" = "deepskyblue", "Invasion" = "red"))	
	
drought_shape <- scale_shape_manual(values = c("Reference" = 22, "Drought" = 24, "Invasion" = 21, "Drought + Invasion" = 23))	
	
short_lab <- c("Reference", "Drought", "Invasion", "Dro + Inv")	
	
trt_surv_fill = scale_fill_manual(	
  values = c(	
    "Drought + Invasion Alive" = "red",	
    "Reference Alive" = "deepskyblue",	
    "Drought Alive" = "deepskyblue",	
    "Invasion Alive" = "red",	
    "Drought + Invasion Dead" = "white",	
    "Reference Dead" = "white",	
    "Drought Dead" = "white",	
    "Invasion Dead" = "white",	
    "Reference" = "deepskyblue", 	
    "Drought" = "deepskyblue", 	
    "Invasion" = "red", 	
    "Drought + Invasion" = "red"	
    )	
)	
	
trt_surv_shape = scale_shape_manual(	
  values = c(	
    "Drought + Invasion Alive" = 23,	
    "Reference Alive" = 22,	
    "Drought Alive" = 24,	
    "Invasion Alive" = 21,	
    "Drought + Invasion Dead" = 23,	
    "Reference Dead" = 22,	
    "Drought Dead" = 24,	
    "Invasion Dead" = 21,	
    "Reference" = 22, 	
    "Drought" = 24, 	
    "Invasion" = 21, 	
    "Drought + Invasion" = 23	
    )	
)	
	
trt_surv_color = scale_color_manual(	
  values = c(	
    "Drought + Invasion Alive" = "red",	
    "Reference Alive" = "deepskyblue",	
    "Drought Alive" = "deepskyblue",	
    "Invasion Alive" = "red",	
    "Drought + Invasion Dead" = "red",	
    "Reference Dead" = "deepskyblue",	
    "Drought Dead" = "deepskyblue",	
    "Invasion Dead" = "red", 	
    "Reference" = "deepskyblue", 	
    "Drought" = "deepskyblue", 	
    "Invasion" = "red", 	
    "Drought + Invasion" = "red"	
    )	
)	
	
def_theme <- theme(legend.title = element_blank(),	
            axis.text = element_text(color = "black"),	
            panel.grid = element_blank()	
            )	
	
dodge <- position_dodge(width=0.9)	
	
pred_plot_theme <- def_theme +	
  theme(legend.position = "none",	
        legend.background = element_blank(),	
        legend.margin = margin(-8,-1,-8,-1),	
        legend.key.height = unit(.75, "line"),	
        axis.text = element_text(color = "black", size = 12),	
        axis.title = element_text(size = 14))	
	
## Figure widths in inches	
fwidth_in1 <- 3.42	
fwidth_in2 <- 4.5	
fwidth_in3 <- 7	
#' 	
#' 	
#' <!-- Only uses data from plots that had living trees when fire was applied. -->	
#' 	
## Individual trees repeated for data from each temperature probe height	
model_data <- read_csv("data/tree_drought_inv_fire.csv")	
model_data <- model_data %>% 	
  mutate(Treatment = factor(Treatment, levels = c("Reference", "Drought","Invasion","Drought + Invasion")),	
         veg_trt = factor(veg_trt, levels = c("Reference", "Invasion")),	
         water_trt = factor(water_trt, levels = c("Reference", "Drought")),	
         surv = ifelse(survival == 0, "Dead","Alive"),	
         trt_surv = paste(Treatment, surv))	
	
## Split data to each probe height	
dat0cm <- droplevels(filter(model_data, probe_ht=="0cm"))	
dat25cm <- droplevels(filter(model_data, probe_ht=="25cm"))	
dat50cm <- droplevels(filter(model_data, probe_ht=="50cm"))	
#' 	
#' 	
#' 	
## Plot-level data for values at each temperature probe height	
plots_data <- model_data %>% 	
  filter(Plot %in% unique(dat25cm$Plot), !duplicated(avg_max_tempC)) %>% 	
  select(Plot, Treatment, veg_trt, water_trt, probe_ht, avg_max_tempC:fuels_kg)	
## 32 unique plots, temperature values from 3 probe height levels	
# n_distinct(dat25cm$Plot)	
	
## Filter data to single probe height so no repeats in plot-level values.	
fuels_data <- plots_data %>% 	
  filter(probe_ht=="25cm") %>% 	
  mutate(trt = factor(Treatment, labels = short_lab))	
	
#' 	
#' 	
#' 	
## Figure 1A	
floads_means_se <- ggplot(fuels_data, aes(trt, fuels_kg)) +	
   	
  geom_point(aes(fill = Treatment, shape = Treatment), 	
             position = position_jitterdodge(dodge.width = .75), 	
             alpha = 1, size = 1, show.legend = T) +	
   	
  stat_summary(fun.data = "mean_se", aes(fill = Treatment, shape = Treatment), 	
               alpha = 1, show.legend = F, size = .5) +	
  	
  scale_y_continuous(limits = c(NA,2)) +	
  	
  treatment_color +	
  treatment_shape +	
  treatment_fill +	
	
  guides(fill = guide_legend(override.aes=list(size = 2, alpha = 1, color = "black"))) +	
  	
  theme_classic() +	
  def_theme +	
  xlab("") +	
  ylab(expression(paste("Fuel load (kg ", {m}^-2, ")"), sep = "")) +	
  theme(	
    legend.position = c(.28, .89),	
        legend.margin = margin(-8,-1,-8,-1),	
        legend.key.height = unit(1, "line"),	
    legend.key.width = unit(1, "mm"),	
        axis.text = element_text(size = 10),	
    axis.text.x = element_text(angle = 45, hjust = 1), 	
        axis.title = element_text(size = 12),	
        legend.text = element_text(size = 8),	
    plot.margin = margin(9,1,-9,0)	
        )	
#' 	
#' 	
#' 	
fuels_data %>% group_by(Treatment) %>% 	
  summarise(`Avg. Fuels (kg)` = mean(fuels_kg),	
            `SD Fuels (kg)` = sd(fuels_kg),	
            n=length(Treatment))	
#' 	
#' 	
#' <!-- # Fuel load model -->	
#' 	
## Fit model	
fuels_model <- lm(fuels_kg ~ Treatment, data = fuels_data)	
	
## ANOVA showing that Treatment affects fuel load	
# car::Anova(fuels_model)	
	
## Summary of model fit	
# summary(fuels_model)	
	
## Model diagnostic plots	
# plot(fuels_model)	
# shapiro.test(residuals(fuels_model))# not exactly normality but model is relatively robust to this issue	
# kruskal.test(fuels_kg ~ Treatment, data = fuels_data)# non-parametric test	
# car::leveneTest(fuels_kg ~ Treatment, data = fuels_data)# homogeneity of var: good	
#' 	
#' 	
#' <!-- `r equatiomatic::extract_eq(fuels_model)` -->	
#' 	
#' <!-- # Flame height model -->	
#' 	
flame_ht_Treatment <- lm(avg_flameht_cm ~ fuels_kg + Treatment, data = fuels_data)	
# shapiro.test(residuals(flame_ht_Treatment))# normality: good	
# car::leveneTest(fuels_kg ~ Treatment, data = fuels_data)# homogeneity of var: good	
	
## Only invasion (Invasion, Invasion + Drought) strongly influenced flame height	
	
## Fit simpler model using dichotomous veg treatment: invasion vs. no invasion	
flame_ht_mod <- lm(avg_flameht_cm ~ fuels_kg + veg_trt, data = fuels_data)	
# shapiro.test(residuals(flame_ht_mod))# normality: good	
# car::leveneTest(fuels_kg ~ veg_trt, data = fuels_data)# homogeneity of var: good	
#' 	
#' 	
#' <!-- `r equatiomatic::extract_eq(flame_ht_Treatment)` -->	
#' 	
#' <!-- `r equatiomatic::extract_eq(flame_ht_mod)` -->	
#' 	
#' 	
fht_mod_pred <- sjPlot::plot_model(flame_ht_mod, type = "pred", terms = c("fuels_kg","veg_trt"))	
  	
fht_fl_fig <- ggplot() +	
  geom_ribbon(data = fht_mod_pred$data %>% filter(group == "Reference"),	
              aes(x = x, ymin = conf.low, ymax = conf.high), alpha = .2, fill = "deepskyblue", show.legend = FALSE) +	
  geom_ribbon(data = fht_mod_pred$data %>% filter(group == "Invasion"),	
              aes(x = x, ymin = conf.low, ymax = conf.high), alpha = .2, fill = "red", show.legend = FALSE) +	
  # 	
  geom_line(data = fht_mod_pred$data %>% filter(group == "Reference"),	
            aes(x = x, y = predicted), show.legend = FALSE, color = "deepskyblue") +	
  geom_line(data = fht_mod_pred$data %>% filter(group == "Invasion"),	
            aes(x = x, y = predicted), show.legend = FALSE, color = "red") +	
	
  geom_point(data = fuels_data,	
             aes(x = fuels_kg, y = avg_flameht_cm,	
                 fill = Treatment, shape = Treatment), alpha = 1, size =  1) +	
  	
  treatment_shape +	
  treatment_fill +	
  guides(fill = guide_legend(override.aes=list(size = 2, alpha = 1))) +	
  	
  scale_x_continuous(limits = c(NA, 2)) +	
  scale_y_continuous(expand = c(.01, 0)) +	
  theme_classic() +	
  def_theme +	
  theme(legend.position = "none",	
        legend.background = element_blank(),	
        legend.margin = margin(-5,2.5,2.5,2.5),	
        ) +	
  xlab(expression(paste("Fuel load (kg ", {m}^-2, ")"), sep = "")) +	
  ylab("Flame height (cm)") +	
  NULL	
# fht_fl_fig	
#' 	
#' 	
#' <!-- # Maximum temperature and heating duration models -->	
#' 	
## Ground level temperatures	
maxtemp0cm <- lm(avg_max_tempC ~ fuels_kg + veg_trt, data = filter(plots_data, probe_ht == "0cm"))	
# sjPlot::plot_model(maxtemp0cm, type = "diag")# good	
maxt_0mod_summary <- summary(maxtemp0cm)	
	
## 25cm temperatures	
maxtemp25cm <- lm(avg_max_tempC ~ fuels_kg + veg_trt, data = filter(plots_data, probe_ht == "25cm"))	
# sjPlot::plot_model(maxtemp25cm, type = "diag")# good	
maxt_25mod_summary <- summary(maxtemp25cm)	
	
## 50 cm temperatures	
maxtemp50cm <- lm(avg_max_tempC ~ fuels_kg + veg_trt, data = filter(plots_data, probe_ht == "50cm"))	
# sjPlot::plot_model(maxtemp50cm, type = "diag")# good	
maxt_50mod_summary <- summary(maxtemp50cm)	
#' 	
#' 	
#' 	
## Ground level heating duration	
sabv100_0cm <- lm(avg_s_abv_100 ~ fuels_kg + veg_trt + avg_fuel_ht_cm, data = filter(plots_data, probe_ht == "0cm"))	
# sjPlot::plot_model(sabv100_0cm, type = "diag")	
# summary(sabv100_0cm)	
	
## 25 cm heating duration	
sabv100_25cm <- lm(avg_s_abv_100 ~ fuels_kg + veg_trt + avg_fuel_ht_cm, data = filter(plots_data, probe_ht == "25cm"))	
# sjPlot::plot_model(sabv100_25cm, type = "diag")	
# summary(sabv100_25cm)	
	
## 50 cm heating duration	
sabv100_50cm <- lm(avg_s_abv_100 ~ fuels_kg + veg_trt + avg_fuel_ht_cm, data = filter(plots_data, probe_ht == "50cm"))	
# sjPlot::plot_model(sabv100_50cm, type = "diag")	
# summary(sabv100_50cm)	
	
## Diagnostic plots look okay for the models. There is some minor heteroscedasticity in residuals, but I don't think it is affecting the model inference or estimates dramatically.	
#' 	
#' 	
#' 	
## Prediction data from maximum temperature models ####	
maxtemp_pred_data <- rbind(	
  ggeffects::ggpredict(maxtemp0cm, terms = c("fuels_kg","veg_trt")) %>% 	
    mutate(location = "0 cm"),	
  ggeffects::ggpredict(maxtemp25cm, terms = c("fuels_kg","veg_trt")) %>% 	
    mutate(location = "25 cm"),	
  ggeffects::ggpredict(maxtemp50cm, terms = c("fuels_kg","veg_trt")) %>% 	
    mutate(location = "50 cm")	
) %>% 	
  mutate(location = factor(location, levels = c("50 cm","25 cm", "0 cm")))	
	
	
## Figure 1C - maximum temperature at 25 cm vs. fuel load ####	
max_temp_pred_fig <- ggplot(maxtemp_pred_data %>% 	
                               filter(location == "25 cm")) +	
  geom_ribbon(data = . %>% filter(group == "Reference"), 	
              aes(x = x, ymin = conf.low, ymax = conf.high), fill = "deepskyblue",	
              alpha = .2, show.legend = FALSE) +	
   	
   geom_ribbon(data = . %>% filter(group=="Invasion"), 	
              aes(x = x, ymin = conf.low, ymax = conf.high), fill = "red",	
              alpha = .2, show.legend = FALSE) +	
   	
  geom_line(data = . %>% filter(group == "Reference"), aes(x = x, y = predicted), color = "deepskyblue", show.legend = FALSE, size = .75) +	
  geom_line(data = . %>% filter(group == "Invasion"), aes(x = x, y = predicted), color = "red", show.legend = FALSE, size = .75) +	
  	
  geom_point(data = plots_data %>% filter(probe_ht == "25cm"), 	
             aes(x = fuels_kg, y = avg_max_tempC, 	
                 fill = Treatment, shape = Treatment), 	
             alpha = 1, size = 1) +	
  	
  scale_x_continuous(limits = c(NA, 2)) +	
  scale_y_continuous(limits = c(0, NA), expand = c(.01,0)) +	
  	
  treatment_fill +	
  treatment_shape +	
  guides(fill = guide_legend(override.aes=list(size = 2, alpha = 1))) +	
	
  xlab(expression(paste("Fuel load (kg ", {m}^-2, ")"), sep = "")) +	
  ylab("Maximum temperature (ºC)") +	
  theme_classic() +	
  def_theme +	
  theme(	
    legend.position = "none",	
    legend.direction = "vertical",	
    legend.background = element_blank(),	
    strip.background = element_blank()	
        ) +	
  NULL	
	
## Figure S1A - maximum temperature at each height vs. fuel load #### 	
max_temp_pred_supp_fig <- ggplot(maxtemp_pred_data) +	
  geom_ribbon(data = . %>% filter(group == "Reference"), 	
              aes(x = x, ymin = conf.low, ymax = conf.high), fill = "deepskyblue",	
              alpha = .2, show.legend = FALSE) +	
   	
   geom_ribbon(data = . %>% filter(group=="Invasion"), 	
              aes(x = x, ymin = conf.low, ymax = conf.high), fill = "red",	
              alpha = .2, show.legend = FALSE) +	
   	
  geom_line(data = . %>% filter(group == "Reference"), aes(x = x, y = predicted), color = "deepskyblue", show.legend = FALSE, size = .75) +	
  geom_line(data = . %>% filter(group == "Invasion"), aes(x = x, y = predicted), color = "red", show.legend = FALSE, size = .75) +	
  	
  geom_point(data = plots_data %>% mutate(location  = case_when(probe_ht=="0cm" ~ "0 cm",	
                                                                probe_ht=="25cm"~"25 cm",	
                                                                probe_ht=="50cm" ~"50 cm")), 	
             aes(x = fuels_kg, y = avg_max_tempC, 	
                 fill = Treatment, shape = Treatment), 	
             alpha = 1, size = 1) +	
  	
  scale_x_continuous(limits = c(NA, 2)) +	
  scale_y_continuous(limits = c(0, NA), expand = c(.01,0)) +	
  treatment_fill +	
  treatment_shape +	
  guides(fill = guide_legend(override.aes=list(size = 2, alpha = 1))) +	
   	
  facet_grid(location~.) +	
  	
  xlab(expression(paste("Fuel load (kg ", {m}^-2, ")"), sep = "")) +	
  ylab("Maximum temperature (ºC)") +	
  theme_bw() +	
  	
  def_theme +	
  theme(	
    legend.position = "none",	
    legend.direction = "vertical",	
    legend.background = element_blank(),	
    strip.background = element_blank()	
        ) +	
  NULL	
	
	
## Heating duration prediction data ####	
## Based on average fuel height of 31.85 cm	
sabv_pred_data <- rbind(	
  ggeffects::ggpredict(sabv100_0cm, terms = c("fuels_kg","veg_trt")) %>% 	
    mutate(location = "0 cm"),	
  ggeffects::ggpredict(sabv100_25cm, terms = c("fuels_kg","veg_trt")) %>% 	
    mutate(location = "25 cm"),	
  ggeffects::ggpredict(sabv100_50cm, terms = c("fuels_kg","veg_trt")) %>% 	
    mutate(location = "50 cm")	
) %>% 	
  mutate(location = factor(location, levels = c("50 cm","25 cm", "0 cm")))	
	
	
## Figure 1D - heating duration at 25 cm vs. fuel load ####	
sabv_100_pred_fig <- ggplot(sabv_pred_data %>% 	
                               filter(location == "25 cm")) +	
  ## Predicted 95% confidence intervals	
  geom_ribbon(data = . %>% filter(group == "Reference"), 	
              aes(x = x, ymin = conf.low, ymax = conf.high), fill = "deepskyblue", alpha = .2, show.legend = FALSE) +	
   geom_ribbon(data = . %>% filter(group == "Invasion"), 	
              aes(x = x, ymin = conf.low, ymax = conf.high), fill = "red",	
              alpha = .2, show.legend = FALSE) +	
  	
  ## Predicted mean lines	
  geom_line(data = . %>% filter(group == "Reference"), aes(x = x, y = predicted), color = "deepskyblue", show.legend = FALSE, size = .75) +	
  geom_line(data = . %>% filter(group == "Invasion"), aes(x = x, y = predicted), color = "red", show.legend = FALSE, size = .75) +	
  	
  ## Raw data points	
  geom_point(data = fuels_data, aes(x = fuels_kg, y = avg_s_abv_100, 	
                 fill = Treatment, shape = Treatment), 	
             alpha = 1, size = 1) +	
  	
  scale_x_continuous(limits = c(NA, 2)) +	
  scale_y_continuous(limits = c(0, NA), expand = c(0,4)) +	
	
  treatment_shape + 	
  treatment_fill +	
  guides(fill = guide_legend(override.aes=list(size = 2, alpha = 1))) +	
  	
  xlab(expression(paste("Fuel load (kg ", {m}^-2, ")"), sep = "")) +	
  ylab("Heating duration (s)") +	
  theme_classic() +	
  def_theme +	
  theme(	
    legend.position = "none",	
    legend.direction = "vertical",	
    legend.margin = margin(-5,2,1,2),	
    strip.background = element_blank(),	
        ) +	
  NULL	
	
	
## Figure S1B - heating duration at each height vs. fuel load ####	
sabv_100_pred_supp_fig <- ggplot(sabv_pred_data) +	
  geom_ribbon(data = . %>% filter(group == "Reference"), 	
              aes(x = x, ymin = conf.low, ymax = conf.high), fill = "deepskyblue", alpha = .2, show.legend = FALSE) +	
   geom_ribbon(data = . %>% filter(group == "Invasion"), 	
              aes(x = x, ymin = conf.low, ymax = conf.high), fill = "red",	
              alpha = .2, show.legend = FALSE) +	
   	
  geom_line(data = . %>% filter(group == "Reference"), aes(x = x, y = predicted), color = "deepskyblue", show.legend = FALSE, size = .75) +	
  geom_line(data = . %>% filter(group == "Invasion"), aes(x = x, y = predicted), color = "red", show.legend = FALSE, size = .75) +	
  	
  geom_point(data = plots_data %>% mutate(location  = case_when(probe_ht=="0cm" ~ "0 cm",	
                                                                probe_ht=="25cm"~"25 cm",	
                                                                probe_ht=="50cm" ~"50 cm")), 	
             aes(x = fuels_kg, y = avg_s_abv_100, 	
                 fill = Treatment, shape = Treatment), 	
             alpha = 1, size = 2) +	
  	
  scale_x_continuous(limits = c(NA, 2)) +	
  scale_y_continuous(limits = c(0, NA), expand = c(0,4)) +	
	
  treatment_shape + 	
  treatment_fill +	
  guides(fill = guide_legend(override.aes=list(size = 2, alpha = 1))) +	
  	
  facet_grid(location~.) +	
  	
  xlab(expression(paste("Fuel load (kg ", {m}^-2, ")"), sep = "")) +	
  ylab("Heating duration (s)") +	
  theme_bw() +	
  	
  def_theme +	
  theme(	
    legend.position = c(.75,.95),	
    legend.background = element_blank(),	
    legend.direction = "vertical",	
    legend.margin = margin(-5,2,1,2),	
    strip.background = element_blank(),	
    legend.key = element_blank()	
        ) +	
  NULL	
	
#' 	
#' 	
#' 	
library(patchwork)	
	
heat_fig <- (max_temp_pred_fig + xlab("") ) |	
  (sabv_100_pred_fig + ylab("Heating duration (s)") + xlab("") )	
	
heat_fig <- heat_fig +	
  xlab(expression(paste("Fuel load (kg ", {m}^-2, ")"), sep = "")) +	
  theme(axis.title.x = element_text(hjust = -.75))	
	
	
#' 	
#' 	
#' 	
#' # Figure 1. Treatment effects on fire	
#' 	
pw <- floads_means_se + ggtitle("") +	
          # scale_y_continuous(limits = c())	
          theme(legend.position = c(.38, .89),	
                legend.key.height = unit(.6, "line"),	
                legend.key.width = unit(1, "mm")) +	
          	
          fht_fl_fig + scale_y_continuous(expand = c(0,5)) + xlab ("") + ggtitle("") +	
          	
          max_temp_pred_fig + ggtitle("") +	
          theme(axis.title.x = element_text(vjust = 10)) +	
          sabv_100_pred_fig + xlab("") + ggtitle("")	
          	
figure1 <- pw +	
  plot_layout(ncol = 4, nrow = 1) +	
  plot_annotation(tag_levels = 'A') &	
  theme(axis.text = element_text(size = 9),	
        axis.title = element_text(size = 11),	
        legend.text = element_text(size = 9),	
        plot.tag = element_text(face = "bold"),	
        plot.tag.position = c(0.02, .95),	
        plot.margin = margin(c(0,2,0,2))	
        )	
figure1	
	
# ggsave("figures/Fig1_top_1200dpi.pdf", figure1, width = 9, height = 3, dpi = 1200)	
## Panels E and F added and figure resized externally using Preview on Mac	
#' 	
#' 	
#' Effects of drought, invasion, and drought + invasion on fuel loads and fire behavior. Invasion produced greater fuel loads, which affected ecologically important aspects of fire behavior. (A) Average fine fuel loads were 57% greater with invasion than without invasion (means ± SE over data points for each plot). See Table S1 for model results. (B) Greater fuel loads produced significantly taller flames, and flame heights were over four times taller in plots with invasion. (C) Maximum temperatures at 25 cm above ground were higher in invasion and increased with fuel load. (D) Heating duration (time above 100 ºC) at 25 cm above ground was longer with invasion but was unaffected by fuel load. Best fit lines ±95% CI in (B, C, D). Predicted lines in (D) are the average fuel height of 109 cm across all plots. Red/dark = invasion, blue/light = no invasion. Point shapes indicate treatment: square = Reference, triangle = Drought, circle = Invasion, diamond = Drought + Invasion (Dro + Inv).	
#' 	
#' 	
#' <!-- # Global change model -->	
#' 	
library(lme4)	
library(sjPlot)	
library(MuMIn)	
library(DHARMa)	
	
survival_ht_trt <- glmer(	
  survival ~ tree_height_cm + Treatment + (1|Plot),	
  family = binomial(link = "logit"), data = dat25cm,	
  glmerControl(optimizer = "Nelder_Mead", optCtrl = list(maxfun=1000000))	
  )	
## check model diagnostics	
simResids <- simulateResiduals(survival_ht_trt)	
# plot(simResids)	
	
# summary(survival_ht_trt)	
# AICc(survival_ht_trt)# 67.1	
# r.squaredGLMM(survival_ht_trt)	
	
#' 	
#' 	
#' <!-- `r equatiomatic::extract_eq(survival_ht_trt)` -->	
#' 	
#' 	
	
ht_trt_pred_plot <- plot_model(survival_ht_trt, type = "pred", pred.type = "fe", show.data = F, terms = c("tree_height_cm [n=10]","Treatment"), show.legend = F)	
# ht_trt_pred_plot$data <- ht_trt_pred_plot$data %>% filter(group!="Drought")	
	
	
glob_drivers_mod <- ggplot(ht_trt_pred_plot$data) +	
  ylab("Survival probability (%)") +	
  xlab("Tree height (cm)") +	
  	
  geom_ribbon(data = . %>% filter(group == "Reference"),	
              aes(x = x, ymin = conf.low, ymax = conf.high), 	
              fill = "deepskyblue",	
              alpha = .2, show.legend = FALSE) +	
  geom_ribbon(data = . %>% filter(group == "Invasion"), 	
              aes(x = x, ymin = conf.low, ymax = conf.high), 	
              fill = "red", alpha = .2, show.legend = FALSE) +	
  geom_ribbon(data = . %>% filter(group == "Drought + Invasion"), 	
              aes(x = x, ymin = conf.low, ymax = conf.high), 	
              fill = "red", alpha = .2, show.legend = FALSE) +	
  	
  geom_point(data = dat25cm,	
             aes(x = tree_height_cm, y = survival, shape = Treatment, fill = Treatment),	
             alpha = .7, size = 2, show.legend = FALSE,	
             position = position_jitter(height = .02, width = 0)	
             ) +	
  	
  geom_line(aes(x = x, y = predicted, color = group, linetype = group), 	
            show.legend = TRUE, size = 1) +	
	
  scale_y_continuous(labels = c("0","25","50","75","100"),	
                     expand = c(0, 0.01)) +	
  scale_x_continuous(expand = c(.035, 0)) +	
  	
  guides(fill = guide_legend(override.aes = list(alpha = 0), label = FALSE)) +	
  	
  treatment_fill +	
  treatment_shape +	
  treatment_color +	
  treatment_lines +	
  theme_classic() +	
  pred_plot_theme +	
  theme(legend.position = c(.75, .2),	
        legend.key.width = unit(.5, "inch"),	
        legend.key.height = unit(.8, "line"))	
	
# ggsave("figures/surv_ht_trt_pred_fig2A.png", glob_drivers_mod,	
       # dpi = 1200, width = 3.42, height = 3.42)	
#' 	
#' 	
#' 	
#' <!-- # Mechanistic model -->	
#' 	
## Model using unscaled predictor variables, including max temp	
## Excludes global drivers (treatment)	
	
mech_model <- glmer(	
  survival ~ tree_height_cm + avg_flameht_cm + avg_max_tempC + avg_s_abv_100 + (1|Plot), 	
  family = binomial(link = "logit"), data = dat25cm,	
  glmerControl(optimizer = "Nelder_Mead", optCtrl = list(maxfun=1000000))	
  )	
# plot(DHARMa::simulateResiduals(mech_model))	
## Decent-looking residual plots	
	
# summary(mech_model)	
# r.squaredGLMM(mech_model)	
#' 	
#' 	
#' <!-- `r equatiomatic::extract_eq(mech_model)` -->	
#' 	
#' 	
	
## Predictions for each variable with others held at mean values	
# avg_flameht_cm =  94.31	
# avg_max_tempC = 433.92	
# avg_s_abv_100 = 104.81	
# tree_height_cm = 339.94	
	
ht_mech_pred_plot <- plot_model(mech_model, type = "pred", pred.type = "fe", show.data = F, terms = c("tree_height_cm [n=10]"))	
ht_mech_pred_plot_data <- ht_mech_pred_plot$data	
	
fht_pred <- plot_model(mech_model, type = "pred", pred.type = "fe", show.data = F, terms = c("avg_flameht_cm"))	
	
max_temp_mech_pred <- plot_model(mech_model, type = "pred", pred.type = "fe", show.data = F, terms = "avg_max_tempC")	
	
surv_sabv100_pred <- plot_model(mech_model, type = "pred", pred.type = "fe", show.data = F, terms = "avg_s_abv_100")	
	
	
relabel_vals <- c("0","25","50","75","100")	
	
## Figure 2E - Marginal effect of tree height ####	
ht_mech_pred_fig <- ggplot(ht_mech_pred_plot_data) +	
  scale_y_continuous(labels = relabel_vals, expand = c(0, .015)) +	
  geom_ribbon(aes(x = x, ymin = conf.low, ymax = conf.high),	
              alpha = .2) +	
  geom_line(aes(x, predicted)) +	
	
  geom_point(data = dat25cm,	
             aes(x = tree_height_cm, y = survival,	
                 shape = Treatment, fill = Treatment),	
             size = 2, alpha = .7,	
             position = position_jitterdodge(jitter.height = .02)) +	
  	
  treatment_color +	
  treatment_fill +	
  treatment_shape +	
  guides(fill = guide_legend(override.aes = aes(alpha = 1, size = 2))) +	
  	
  ylab("Survival probability (%)") +	
  xlab("Tree height (cm)") +	
  ggtitle("") +	
  theme_classic() +	
  pred_plot_theme +	
  theme(legend.position = c(.8,.3)) +	
  NULL	
# ggsave("figures/surv_treeht_mech_model_pred.png", ht_mech_pred_fig, width = 3.42, height = 3.42, dpi = 1200)	
	
	
## Figure 2E - Marginal effect of flame height	
fh_mech_pred_fig <- fht_pred +	
  	
  geom_point(data = dat25cm,	
             aes(x = avg_flameht_cm, y = survival, shape = Treatment, 	
                 fill = Treatment),	
             alpha = .7, size = 2, show.legend = FALSE,	
             position = position_jitter(height = .02, width = 0)) +	
	
  scale_y_continuous(labels = relabel_vals, expand = c(0, .015)) +	
  scale_x_continuous(expand = c(0,3), limits = c(0, 290),	
                     breaks = seq(0, 300, 50), labels = seq(0, 300, 50)) +	
  	
  trt_surv_color + trt_surv_fill + trt_surv_shape +	
  	
  ylab("Survival probability (%)") +	
  xlab("Flame height (cm)") +	
  ggtitle("") +	
  theme_classic() +	
  pred_plot_theme +	
  NULL	
# ggsave("figures/surv_flameht_mech_model_pred.png", fh_mech_pred_fig, width = 3.42, height = 3.42, dpi = 1200)	
	
	
## Fig S2A - Marginal effect of maximum temperature ####	
max_temp_mech_pred_fig <- ggplot(max_temp_mech_pred$data) +	
  scale_y_continuous(labels = relabel_vals, expand = c(0, .015)) +	
  geom_ribbon(aes(x = x, ymin = conf.low, ymax = conf.high),	
              alpha = .2) +	
  geom_line(aes(x, predicted)) +	
  geom_point(data = dat25cm,	
             aes(x = avg_max_tempC, y = survival, shape = Treatment, fill = Treatment),	
             alpha = .7, size = 2, show.legend = FALSE,	
             position = position_jitter(height = .02, width = 0)) +	
  	
  treatment_color +	
  treatment_fill +	
  treatment_shape +	
  	
  guides(fill = guide_legend(override.aes = aes(alpha = 1, size = 2))) +	
  	
  ylab("Survival probability (%)") +	
  xlab("Maximum temperature (ºC)") +	
  ggtitle("") +	
  theme_classic() +	
  pred_plot_theme +	
  NULL	
	
	
## Fig S2B - Marginal effect of heating duration ####	
surv_sabv100_pred_fig <- surv_sabv100_pred +	
  geom_point(data = dat25cm, 	
             aes(x=avg_s_abv_100, y=survival, shape = Treatment, 	
                 fill = Treatment), 	
             size = 2, alpha = .7,	
             position = position_jitter(height = .02)) +	
  	
  scale_y_continuous(labels = relabel_vals) +	
  	
  treatment_color +	
  treatment_shape +	
  treatment_fill +	
  	
  ylab("Survival probability (%)") +	
  xlab("Seconds above 100ºC") +	
  ggtitle("") +	
  theme_classic() +	
  pred_plot_theme +	
  NULL	
	
#' 	
#' 	
#' 	
df2 <- dat25cm %>% 	
  filter(survival == "Dead") %>% 	
  group_by(trt_surv) %>% 	
  summarise(ymean = mean(tree_height_cm),	
            ysd = sd(tree_height_cm),	
            xmean = mean(avg_flameht_cm),	
            xsd = sd(avg_flameht_cm))	
df3 <- dat25cm %>% 	
  filter(surv == "Alive") %>% 	
  group_by(trt_surv) %>% 	
  summarise(ymean = mean(tree_height_cm),	
            ysd = sd(tree_height_cm),	
            xmean = mean(avg_flameht_cm),	
            xsd = sd(avg_flameht_cm))	
	
## Figure 2A ####	
tht_fht_mort_figA <- ggplot() +	
  geom_point(data = dat25cm,	
             aes(x = avg_flameht_cm, y = tree_height_cm,	
                 fill = trt_surv, shape = trt_surv, color = trt_surv),	
             size = 2.5, alpha = .5) +	
  geom_errorbar(data = df3, aes(x = xmean, ymin = ymean - ysd, ymax = ymean + ysd, color = trt_surv), width = 0, color = "black") +	
  geom_errorbarh(data = df3, aes(y = ymean, xmin = xmean - xsd, xmax = xmean + xsd, color = trt_surv), height = 0, color = "black") +	
  geom_point(data = df3, aes(x = xmean, y = ymean, fill = trt_surv, shape = trt_surv), 	
             size = 4) +	
  	
  geom_errorbar(data = df2, aes(x = xmean, ymin = ymean - ysd, ymax = ymean + ysd, color = trt_surv), width = 0, color = "black") +	
  geom_errorbarh(data = df2, aes(y = ymean, xmin = xmean - xsd, xmax = xmean + xsd, color = trt_surv), height = 0, color = "black") +	
  geom_point(data = df2, aes(x = xmean, y = ymean, color = trt_surv, fill = trt_surv, shape = trt_surv), size = 4) +	
  	
  geom_text(aes(x = 200, y = 20, label = "open = dead")) +	
  	
  trt_surv_color + trt_surv_fill + trt_surv_shape +	
  	
  scale_y_continuous(expand = c(0,18)) +	
  scale_x_continuous(expand = c(0,3), limits = c(0, 290),	
                     breaks = seq(0, 300, 50), labels = seq(0, 300, 50)) +	
	
  xlab("Flame height (cm)") + 	
  ylab("Tree height (cm)") +	
  theme_classic() +	
  pred_plot_theme +	
  theme(legend.position = "none",	
        plot.background = element_blank()) +	
  NULL	
	
	
## Figure 2B ####	
mortality <- dat25cm %>% 	
  mutate(trt = factor(Treatment, labels = short_lab)) %>% 	
  group_by(trt) %>% 	
  summarise(pct_mortality = 100 * (1 - (sum(survival)/length(tree_id)))) %>% 	
  ungroup(.)	
	
tht_fht_mort_figB <- ggplot(mortality, aes(trt, pct_mortality)) +	
  geom_point(aes(shape = trt, color = trt), size = 2.5) +	
  trt_shp +	
  trt_col +	
  scale_y_continuous(position = "left", limits = c(0, 50), 	
                     expand = c(0, 1)) +	
  scale_x_discrete(guide = guide_axis(angle = 50), expand = c(0, 0.3)) +	
  ylab("Mortality (%)") +	
  xlab("") +	
  theme_gray() +	
  pred_plot_theme +	
  theme(legend.position = "none",	
        panel.border = element_rect(fill = NA, color = "black"),	
        axis.text.x = element_text()	
        ) +	
  NULL	
	
th_fh_mort_fig <- tht_fht_mort_figA + 	
  theme(axis.title.x = element_text(vjust = 13)) + 	
  tht_fht_mort_figB +	
  plot_layout(widths = c(7,3))	
# th_fh_mort_fig	
#' 	
#' 	
#' # Figure 2. Global change drivers and mechanisms	
#' 	
# glob_drivers_mod	
# th_fh_mort_fig	
# ht_mech_pred_fig	
# fh_mech_pred_fig	
# max_temp_mech_pred_fig	
# surv_sabv100_pred_fig	
	
gd <- glob_drivers_mod +	
  theme(legend.margin = margin(c(0,0,0,0)),	
        legend.background = element_blank(),	
        legend.position = c(.745, .02),	
        axis.title.x = element_text(vjust = 13)	
        )	
	
gdmech_fig <- 	
  th_fh_mort_fig -	
  gd + theme(legend.position = c(.7, .05),	
             axis.title.y = element_text(vjust = -1)) +	
  fh_mech_pred_fig + theme(axis.title.y = element_text(vjust = -1)) +	
  ht_mech_pred_fig + theme(legend.position = c(.7, .25),	
                           axis.title.y = element_text(vjust = -1)) #+ 	
  # max_temp_mech_pred_fig + surv_sabv100_pred_fig + ylab("")	
  	
figure2 <- gdmech_fig + plot_layout(ncol = 2) +	
  plot_annotation(tag_levels = 'A') &	
  theme(axis.title = element_text(size = 16),	
        axis.text = element_text(size = 12),	
        legend.text = element_text(size = 12), 	
        plot.tag = element_text(face = "bold"),	
        plot.tag.position = c(.02,.99),	
        plot.margin = margin(t = 2, r = 5, b = 1, l = 1)	
        )	
figure2	
	
# ggsave("figures/global_drivers_mech_fig.png", figure2, width = 8, height = 8, dpi = 150)	
# ggsave("figures/Fig2_global_drivers_mech_1200dpi.pdf", figure2, width = 8, height = 8, dpi = 1200)	
## Resized externally using Preview on Mac OS	
#' 	
#' 	
#' Mechanistic effects of drought, invasion, and drought + invasion on tree survival following fires. (A) Trees in the drought + invasion treatment (diamond) were generally shorter than with invasion alone (circle), and flames were taller in invaded plots (means ±1 SD of tree height and flame height for surviving (filled) and dead (open) trees; small points for individual trees; red/dark = invasion, blue/light = no invasion). (B) As a result, tree mortality under the drought + invasion treatment was much higher (44%) than in reference (10%), invasion alone (10%), or drought alone (no mortality). (C) The model of global change drivers (drought, invasion) effects on tree survival showed that fire survival probability was determined by tree height and invasion, but not drought (dashed line at 100% obscured by points). (D) Tree height and (E) flame height were significant factors determining tree survival in the mechanistic model, which also included maximum temperature and heating duration (but not experimental treatments). Predicted lines ±95% CI; points on C – E are individual trees (vertically jittered for visibility), shape indicates plot treatment.	
#' 	
#' 	
#' <!-- # Management Model -->	
#' 	
#' 	
management_model <- glmer(	
  survival ~ tree_height_cm + fuels_kg*veg_trt + (1|Plot), 	
  family = binomial(link = "logit"), data = dat25cm,	
  glmerControl(optimizer = "Nelder_Mead", optCtrl = list(maxfun=1000000))	
  )	
# plot(simulateResiduals(management_model))	
# summary(management_model)	
# MuMIn::AICc(management_model)# 58.6	
# r.squaredGLMM(management_model)	
#' 	
#' 	
#' <!-- `r equatiomatic::extract_eq(management_model)` -->	
#' 	
#' 	
## Survival probability vs. tree height in Reference or Invasion plots	
tht_veg_drywt_pred <- plot_model(management_model, type = "pred", terms = c("tree_height_cm [n=15]","veg_trt"), pred.type = "fe")	
## Prediction for fuel load of 0.91 kg	
	
fig3a <- ggplot(data = tht_veg_drywt_pred$data) +	
  ylab("Survival probability (%)") +	
  xlab("Tree height (cm)") +	
  scale_y_continuous(labels = relabel_vals,	
                     expand = c(0, 0.02)) +	
  scale_x_continuous(expand = c(.035, 0)) +	
  	
  geom_ribbon(data = . %>% filter(group == "Reference"),	
              aes(x = x, ymin = conf.low, ymax = conf.high), 	
              fill = "deepskyblue",	
              alpha = .2, show.legend = FALSE) +	
   	
  geom_ribbon(data = . %>% filter(group=="Invasion"), 	
              aes(x = x, ymin = conf.low, ymax = conf.high), 	
              fill = "red", alpha = .2, show.legend = FALSE) +	
  	
  geom_line(data = . %>% filter(group == "Reference"), 	
            aes(x = x, y = predicted), 	
            color = "deepskyblue", show.legend = FALSE, size = .75) +	
  geom_line(data = . %>% filter(group == "Invasion"), 	
            aes(x = x, y = predicted), 	
            color = "red", show.legend = FALSE, size = .75) +	
  	
  geom_point(data = dat25cm, 	
             aes(x = tree_height_cm, y = survival, fill = Treatment, 	
                 shape = Treatment), 	
             alpha = 1, size = 2, 	
             position = position_jitterdodge(jitter.height = .02)) +	
  treatment_fill +	
  treatment_color +	
  treatment_shape +	
  guides(fill = guide_legend(override.aes=list(size = 2, alpha = 1))) +	
  theme_classic() +	
  pred_plot_theme +	
  theme(legend.position = c(.8, .3))	
	
#' 	
#' 	
#' 	
## Survival probability vs. fuel load in Reference or Invasion plots	
fuels_veg_tht_pred <- plot_model(management_model, type = "pred", terms = c("fuels_kg [n=25]","veg_trt"), pred.type = "fe")	
	
	
fig3b <- ggplot(data = fuels_veg_tht_pred$data) +	
  scale_x_continuous(limits = c(0.35, 2.0), expand = c(0, .02)) +	
  scale_y_continuous(labels = relabel_vals, expand = c(0, 0.02)) +	
  ylab("Survival (%)") +	
  xlab("Fuel load (kg)") +	
  	
  geom_ribbon(data = . %>% filter(group == "Reference"),	
              aes(x = x, ymin = conf.low, ymax = conf.high), 	
              fill = "deepskyblue",	
              alpha = .2, show.legend = FALSE) +	
   	
  geom_ribbon(data = . %>% filter(group=="Invasion"), 	
              aes(x = x, ymin = conf.low, ymax = conf.high), 	
              fill = "red", alpha = .2, show.legend = FALSE) +	
  	
  geom_line(data = . %>% filter(group == "Reference"), 	
            aes(x = x, y = predicted), 	
            color = "deepskyblue", show.legend = FALSE, size = .75) +	
  geom_line(data = . %>% filter(group == "Invasion"), 	
            aes(x = x, y = predicted), 	
            color = "red", show.legend = FALSE, size = .75) +	
  	
  geom_point(data = dat25cm, 	
             aes(x = fuels_kg, y = survival, fill = Treatment, 	
                 shape = Treatment), 	
             alpha = 1, size = 2,	
             position = position_jitterdodge(jitter.height = .02)) +	
  treatment_fill +	
  treatment_shape +	
  guides(fill = guide_legend(override.aes=list(size = 4, alpha = 1))) +	
  theme_classic() +	
  pred_plot_theme +	
  NULL	
# plot_model(surv_unscl_drywt4, type = "pred", terms = c("drywt_kg [0.5,1.28,1.3]","veg_trt"))$data	
#' 	
#' 	
#' 	
## Survival predictions for fuel loads of 0.6 kg and 1.2 kg	
surv_fuel_pred <- plot_model(	
  management_model, type = "pred", 	
  terms = c("tree_height_cm [n=20]","veg_trt","fuels_kg [.6, .9, 1.2]"), 	
  show.data = FALSE,show.legend = FALSE, pred.type = "fe"	
  )	
	
surv_fuel_pred$data$facet <- factor(	
  surv_fuel_pred$data$facet, labels = c("Fuel load: 0.6 kg", "Fuel load: 0.9 kg", "Fuel load: 1.2 kg"))	
surv_fuel_pred_data <- surv_fuel_pred$data	
	
surv_fuel_pred_fig <- ggplot(data = surv_fuel_pred_data %>% 	
                               filter(facet == "Fuel load: 0.6 kg"))	
surv_fuel_pred_figB <- ggplot(data = surv_fuel_pred_data %>% 	
                               filter(facet == "Fuel load: 1.2 kg"))	
	
fig3c <- surv_fuel_pred_fig +	
  scale_y_continuous(labels = relabel_vals, expand = c(0, 0.02)) +	
  ylab("Survival (%)") +	
  xlab("Tree height (cm)") +	
  geom_ribbon(data = . %>% filter(group == "Reference"),	
              aes(x = x, ymin = conf.low, ymax = conf.high), 	
              fill = "deepskyblue", alpha = .2, show.legend = FALSE) +	
  geom_ribbon(data = . %>% filter(group=="Invasion"), 	
              aes(x = x, ymin = conf.low, ymax = conf.high), 	
              fill = "red", alpha = .2, show.legend = FALSE) +	
  geom_line(data = . %>% filter(group == "Reference"), 	
            aes(x = x, y = predicted), 	
            color = "deepskyblue", show.legend = FALSE, size = .75) +	
  geom_line(data = . %>% filter(group == "Invasion"), 	
            aes(x = x, y = predicted), 	
            color = "red", show.legend = FALSE, size = .75) +	
  	
  facet_wrap(facets = ~facet) +	
  	
  geom_point(data = dat25cm, 	
             aes(x = tree_height_cm, y = survival, fill = Treatment, 	
                 shape = Treatment), 	
             alpha = 1, size = 2,	
             position = position_jitterdodge(jitter.height = .02)) +	
  	
  treatment_fill +	
  treatment_shape +	
  guides(fill = guide_legend(override.aes=list(size = 2, alpha = 1))) +	
  	
  theme_classic() +	
  pred_plot_theme +	
  theme(strip.background = element_blank(),	
        strip.text = element_text(size = 12),	
        ) +	
  NULL	
# fig3c	
	
fig3d <- surv_fuel_pred_figB +	
  scale_y_continuous(labels = relabel_vals, expand = c(0, 0.02)) +	
  ylab("Survival (%)") +	
  xlab("Tree height (cm)") +	
  geom_ribbon(data = . %>% filter(group == "Reference"),	
              aes(x = x, ymin = conf.low, ymax = conf.high), 	
              fill = "deepskyblue", alpha = .2, show.legend = FALSE) +	
  geom_ribbon(data = . %>% filter(group=="Invasion"), 	
              aes(x = x, ymin = conf.low, ymax = conf.high), 	
              fill = "red", alpha = .2, show.legend = FALSE) +	
  geom_line(data = . %>% filter(group == "Reference"), 	
            aes(x = x, y = predicted), 	
            color = "deepskyblue", show.legend = FALSE, size = .75) +	
  geom_line(data = . %>% filter(group == "Invasion"), 	
            aes(x = x, y = predicted), 	
            color = "red", show.legend = FALSE, size = .75) +	
  	
  facet_wrap(facets = ~facet) +	
  	
  geom_point(data = dat25cm, 	
             aes(x = tree_height_cm, y = survival, fill = Treatment, 	
                 shape = Treatment), 	
             alpha = 1, size = 2,	
             position = position_jitterdodge(jitter.height = .02)) +	
  	
  treatment_fill +	
  treatment_shape +	
  guides(fill = guide_legend(override.aes=list(size = 2, alpha = 1))) +	
  	
  theme_classic() +	
  pred_plot_theme +	
  theme(strip.background = element_blank(),	
        strip.text = element_text(size = 12),	
        )	
# fig3d	
#' 	
#' 	
#' # Figure 3. Management model predictions	
#' 	
	
p1 <- fig3a + theme(legend.position = c(.7,.3))	
p2 <- fig3b  + ylab(" ")	
p3 <- fig3c + ylab("Survival probability (%)") + xlab("")	
p4 <- fig3d + ylab(" ") + xlab("")	
	
p <- (p1|p2) / ((p3|p4) + xlab("Tree height (cm)") + 	
                  theme(axis.title.x = element_text(hjust = -1)))	
  	
figure3 <- p + plot_annotation(tag_levels = 'A') &	
  theme(plot.tag = element_text(face = "bold"))	
figure3	
	
# ggsave("figures/management_model_figure.pdf", figure3, dpi = 1200, width = 7, height = 7)	
#' 	
#' 	
#' Management implications for effects of tree height and fuel load on tree survival. (A) The predicted effect of tree height (conditioned on average fuel load across all plots of 0.91 kg m-2) on tree survival was mediated by invasion, in which trees had to be significantly taller to survive fire. (B) Greater fuel loads (conditioned on average tree height across all plots of 340 cm) were predicted to reduce survival with, but not without invasion. (C, D) Model predictions for 0.6 kg m-2 and 1.2 kg m-2 fuel loads underscored strong invader effects on tree survival probability across tree heights. Lines and shading are predicted means ±95% CI. Points are individual trees and shape indicates plot treatment. Red/dark = invasion, blue/light = no invasion.	
#' 	
#' 	
#' # Supplemental Tables	
#' 	
#' ## Table S1 Treatment effects on fuel loads	
#' 	
#' 	
broom::tidy(fuels_model) %>% 	
  rename(Term = term, Estimate = estimate, SE = std.error, `t-value` = statistic, `P-value` = p.value) %>% 	
  knitr::kable(digits = 3, caption = "Model results for treatment effects on average fuel loads relative to the Reference plots (adjusted R2 = 0.33). Note that we only included fuel load data for plots with trees in them at the time of the  fires (N = 32 plots. Reference = 10, Invasion = 6, Drought = 8, Drought + Invasion = 8).")	
	
# tab_model(fuels_model)	
#' 	
#' 	
#' ## Table S2 Flame height model summary	
#' 	
#' 	
broom::tidy(flame_ht_Treatment) %>% 	
  rename(Term = term, Estimate = estimate, SE = std.error, `t-value` = statistic, `P-value` = p.value) %>% 	
  knitr::kable(digits = 3, caption = "Coefficient estimates and p-values for the model of flame height affected by treatment (adjusted R2 = 0.84). Best fit lines in Fig. 1B are a simplified model of no invasion (Reference, Drought) versus invasion (Invasion, Drought + Invasion)")	
# tab_model(flame_ht_Treatment)	
#' 	
#' 	
#' ## Table S3. Maximum temperature models summaries	
#' 	
maxt0cm_coefs <- broom::tidy(maxtemp0cm) %>% 	
  mutate(probe_ht = "0 cm") %>% 	
  select(probe_ht, everything())	
	
maxt_25cm_coefs <- broom::tidy(maxtemp25cm) %>% 	
  mutate(probe_ht = "25 cm") %>% 	
  select(probe_ht, everything())	
	
maxt_50cm_coefs <- broom::tidy(maxtemp50cm) %>% 	
  mutate(probe_ht = "50 cm") %>% 	
  select(probe_ht, everything())	
	
## Combine estimates from each model	
maxtemp_mod_coefs <- rbind(maxt_50cm_coefs, maxt_25cm_coefs, maxt0cm_coefs)	
	
## Get R2 values and combine with probe height	
maxtr2 <- c(maxt_0mod_summary$adj.r.squared, maxt_25mod_summary$adj.r.squared, maxt_50mod_summary$adj.r.squared)	
probe_ht <- c("0 cm", "25 cm", "50 cm")	
maxtemp_r2 <- as.data.frame(cbind(probe_ht, adj.r2 = round(maxtr2, digits = 2)))	
	
## Generate Table S3	
knitr::kable(left_join(maxtemp_mod_coefs, maxtemp_r2), digits = 3, 	
             caption = "Coefficient estimates and adjusted R2 for models of maximum temperature at each probe height. Results are illustrated in Fig. S1.")	
#' 	
#' 	
#' ## Table S4. Heating duration models summaries	
#' 	
sabv100_50cm_coefs <- broom::tidy(sabv100_50cm) %>% 	
  mutate(probe_ht = "50 cm") %>% 	
  select(probe_ht, everything())	
	
sabv100_25cm_coefs <- broom::tidy(sabv100_25cm) %>% 	
  mutate(probe_ht = "25 cm") %>% 	
  select(probe_ht, everything())	
	
sabv100_0cm_coefs <- broom::tidy(sabv100_0cm) %>% 	
  mutate(probe_ht = "0 cm") %>% 	
  select(probe_ht, everything())	
	
## Extract R-squared for each model	
sabv100_r2 <- as.data.frame(cbind(probe_ht, adj.r2 = round( c(summary(sabv100_0cm)$adj.r.squared, summary(sabv100_25cm)$adj.r.squared, summary(sabv100_50cm)$adj.r.squared), digits = 2)))	
	
## Combine coefficient estimates from each model	
sabv100_coefs <- rbind(sabv100_50cm_coefs, sabv100_25cm_coefs, sabv100_0cm_coefs)	
	
## Combine coefficient estimates and R-squared values into Table S4	
knitr::kable(left_join(sabv100_coefs, sabv100_r2), digits = 3, 	
             caption = "Coefficient estimates and adjusted R2 for models of heating duration (seconds above 100 ºC) at each probe height. Results are illustrated in Fig. S1")	
#' 	
#' 	
#' ## Table S5. Summary of treatment and fire effects. 	
#' 	
dat25cm %>% 	
  group_by(Treatment) %>% 	
  summarise(plots = n_distinct(Plot),	
            trees = length(tree_id),	
            treatment_effect_pct = 100*((75-trees)/75),	
            dead = sum(dead),	
            alive = sum(alive),	
            fire_effect_pct = 100*((alive - trees)/trees),	
            avg_height = mean(tree_height_cm),	
            sd_height = sd(tree_height_cm),	
            pct_survival = 100*sum(survival)/length(survival),	
            sd_pct_survival = 100*(sd(survival, na.rm = TRUE))) %>% 	
  knitr::kable(., digits = 1,	
               caption = "Summary of treatment and fire effects, tree height, and proportion survival in each treatment group. Treatment effect pre-fire is number of trees alive under each treatment relative to the number of trees in the Reference plots. Fire effect is number of trees alive after fires relative to before fires. Standard deviations (SD) of height calculated across trees and SD of survival estimated across plots.")	
#' 	
#' 	
#' ## Table S6. Global change model summary	
#' 	
smod_ht_trt_coef_plot <- plot_model(survival_ht_trt, show.values = TRUE, digits = 3, colors = "bw") +	
  scale_y_log10(limits = c(NA, NA))	
	
smod_ht_trt_coef_plot$data %>% 	
  select(Term = term, `Estimated OR` = estimate, conf.low, conf.high, `P-value` = p.value) %>% 	
  knitr::kable(caption = "The estimates for the treatment terms are in comparison to the “Reference” treatment (no invasion or drought). Model term, estimated odds-ratio (OR), 95% confidence interval (CI) of the OR, P-value of the estimate. Model predictions are illustrated in Figure 2C.", 	
               digits = 3)	
#' 	
#' 	
#' ## Table S7. Global change model predictions	
#' 	
gc_pred <- plot_model(survival_ht_trt, type = "pred", pred.type = "fe", show.data = F, terms = c("tree_height_cm [70, 150, 270, 340]", "Treatment"))	
gc_pred$data %>% 	
  rename(tree_height_cm = x, surv_probability = predicted, Treatment = group) %>% 	
  select(-std.error, -group_col) %>% 	
  knitr::kable(digits = 2, caption = "Predicted tree survival probability following fire from the global change model for specific values of tree height under each treatment.")	
#' 	
#' 	
#' ## Table S8. Mechanistic model summary	
#' 	
temp_model_coef <- plot_model(mech_model, show.values = T, colors = "bw", digits = 3)	
temp_model_coef$data$term <- c("Tree ht (cm)", "Flame ht (cm)", "Max temp (ºC)", "s >100 ºC") 	
	
temp_model_coef$data %>% 	
  select(term, estimate, conf.low, conf.high, p.value) %>% 	
  knitr::kable(digits = 3, caption = "Mechanistic model summary. Term, estimated odds ratio (OR), 95% confidence interval of the OR, P-value of the estimate. Model predictions are illustrated in Figures 2D, E, and S2.")	
# broom.mixed::glance(mech_model)	
# r.squaredGLMM(mech_model)	
#' 	
#' 	
#' ## Table S9. Mechanistic model predictions	
#' 	
mm_predictions <- plot_model(mech_model, type = "pred", pred.type = "fe",	
                           terms = c("tree_height_cm [100,150,200,300,400,600]", "avg_flameht_cm [50,94,100,200]"))	
	
mm_predictions$data %>% 	
  filter(group %in% c("50", "100", "200"), x %in% c(100, 200, 300, 400)) %>% 	
  arrange(group) %>% 	
  rename(`Tree height (cm)` = x, `% survival probability` = predicted,	
         `Flame height (cm)` = group) %>% 	
  select(-std.error, -group_col) %>% 	
  knitr::kable(digits = 2, caption = "Mechanistic model predictions. Predicted tree survival probability from the mechanistic model for specific values of tree height and flame height. Predictions are for the mean values of maximum temperature (434 ºC) and heating duration (105 seconds).")	
#' 	
#' 	
#' ## Table S10. Management model summary	
#' 	
invasion_fuel_coef <- plot_model(management_model, show.values = TRUE, digits = 3, color = "bw", ci.style = "whisker")	
invasion_fuel_coef$data$term <- c("Tree ht (cm)","Fuel load (kg)","Invasion","Fuel load*Invasion")	
	
# tab_model(management_model)	
invasion_fuel_coef$data %>% 	
  select(Term = term, `Estimated OR` = estimate, conf.low, conf.high, `P-value` = p.value) %>% 	
  knitr::kable(digits = 4, caption = "Management model summary. Term, estimated odds ratio (OR), 95% confidence interval of the OR, P-value of the estimate. Model predictions are illustrated in Figure 3.")	
	
# (invasion_fuel_coef <- invasion_fuel_coef +	
#   scale_y_log10() +	
#   pred_plot_theme +	
#   ggtitle("")	
# )	
#' 	
#' 	
#' ## Table S11. Management model summary	
#' 	
surv_fuel_pred <- plot_model(	
  management_model, type = "pred", 	
  terms = c("tree_height_cm [10, 50, 100, 200, 300, 400]","veg_trt","fuels_kg [.6, .9, 1.2]"), 	
  show.data = FALSE,show.legend = FALSE, pred.type = "fe"	
  )	
	
surv_fuel_pred$data %>%	
  select(`Tree height (cm)` = x, `% survival probability` = predicted, 	
         conf.low, conf.high, Group = group,	
         `Fuel load` = facet) %>%	
  mutate(Group = ifelse(Group=="Reference", "No invasion", "Invasion")) %>%	
  arrange(`Fuel load`) %>%	
  knitr::kable(digits = 2, caption = "Table S11. Management model predictions. Average survival probability with or without invasion across a range of tree heights for three different fuel loads.")	
#' 	
#' 	
#' ## Tree height multiple comparison	
#' 	
	
library(lme4)	
library(sjPlot)	
library(DHARMa)	
	
# ggsave("figures/treeht_trt_boxplot.pdf", width = 7, height = 7, dpi = 600)	
	
knitr::kable(dat25cm %>% 	
         group_by(Treatment) %>% 	
         summarise(nobs = length(tree_height_cm),	
                   avg_ht = mean(tree_height_cm),	
                   sd = sd(tree_height_cm, na.rm = T)),	
         digits = 1, caption = "Average tree height")	
	
	
tree_ht_mod <- lmer(tree_height_cm ~ Treatment + (1|Plot), data = dat25cm)	
# summary(tree_ht_mod)	
(tree_ht_mod_Anova <- car::Anova(tree_ht_mod, test.statistic = c("F")))	
	
# broom.mixed::tidy %>% 	
# broom.mixed::tidy(tree_ht_mod) %>%	
#   knitr::kable(., caption = "Tree height model results")	
	
tree_ht_mod_coefs <- plot_model(tree_ht_mod, show.values = T, color = "bw", 	
                                value.size = 6)	
	
# tree_ht_mod_coefs$data$term <- c("Drought","Invasion","Invasion X Drought")	
	
tree_ht_mod_coefs +	
  # scale_x_discrete(limits = c("Invasion X Drought", "Drought", "Invasion")) +	
  theme_classic() +	
  geom_hline(yintercept = 0, color = "grey90") +	
  ggtitle("") +	
  ylab("Est. effect on tree height (cm)") +	
  def_theme +	
  # theme(axis.text = element_text(color = "black")) +	
  NULL	
	
tab_model(tree_ht_mod)	
# MuMIn::r.squaredGLMM(tree_ht_mod)# plot random effect increase R2 over 2x	
tree_ht_multcomp <- multcomp::glht(	
  tree_ht_mod,linfct=multcomp::mcp(Treatment="Tukey")	
  )	
summary(tree_ht_multcomp)	
# plot(print(confint(tree_ht_multcomp)))	
	
th_cld <- multcomp::cld(tree_ht_multcomp)	
th_cld	
# plot(th_cld)	
# old.par <- par(mai=c(1,1,1.25,1), no.readonly = TRUE)	
	
# pairwise.t.test(dat25cm$tree_height_cm, dat25cm$Treatment)	
# pairwise.t.test(dat25cm$tree_height_cm, dat25cm$Treatment, p.adjust.method = "bonf")	
	
	
m1 <- nlme::lme(tree_height_cm ~ Treatment, random = ~1|Plot, data = dat25cm)	
# summary(m1)	
	
	
m2 <- nlme::lme(tree_height_cm ~ veg_trt + water_trt + veg_trt:water_trt, random = ~1|Plot, data = dat25cm)	
# summary(m2)	
	
# summary(m1)$coef$fixed	
# summary(m2)$coef$fixed	
	
# plot_model(tree_ht_mod, type = "pred") 	
#   invasion_color +	
#   theme_classic() +	
#   ggtitle("") +	
#   ylab("Tree height (cm)") +	
#   # xlab("Ambient - Drought") +	
#   def_theme +	
#   NULL	
	
# ggsave("figures/treeht_coef.pdf", height = 7, width = 7, dpi = 600)	
#' 	
#' 	
#' # Supplemental Figures	
#' 	
#' ## Figure S1. Fuel load vs. maximum temperature or heating duration at each probe height	
#' 	
heat_fig_supp <- max_temp_pred_supp_fig +	
  xlab("") +	
  theme(strip.text = element_blank()) +	
  sabv_100_pred_supp_fig + xlab("")	
	
figS1 <- heat_fig_supp +	
  xlab(expression(paste("Fuel load (kg ", {m}^-2, ")"), sep = "")) +	
  theme(axis.title.x = element_text(hjust = -.75),	
        legend.key.height = unit(1, "line"),	
        legend.key.width = unit(.1, "cm"),	
        legend.position = c(.755, .94)) +	
  plot_annotation(tag_levels = "A") &	
  theme(plot.tag = element_text(face = "bold"))	
figS1	
# ggsave("figures/fire_temperatures_supp_fig.pdf", figS1, height = 8, width = 7, dpi = 300)	
#' 	
#' 	
#' Best fit lines ±95% confidence intervals (shaded) illustrating the relationship between fuel load and maximum temperatures (A) or heating duration (B) at each probe height above ground level (0 cm, 25 cm, and 50 cm). Data points are shown for the three sensors at each height in each plot to illustrate variation in the fire behavior. Predictions of heating duration (seconds above 100 ºC) are for the mean fuel height value across all plots (109 cm). Red/dark = invasion, blue/light = no invasion. 	
#' 	
#' ## Figure S2. Mehanistic model maximum temperature and heating duration	
#' 	
#' 	
figS2 <- max_temp_mech_pred_fig + theme(legend.position = c(.7, .3)) + 	
  surv_sabv100_pred_fig + ylab("") + xlab("Heating duration (s)") +	
  plot_annotation(tag_levels = 'A') &	
  theme(plot.tag = element_text(face = "bold"))	
figS2	
# ggsave("figures/mech_model_supp_fig.pdf", figS2, width = 7, height = 3.5, dpi = 300)	
#' 	
#' 	
#' Estimated effects ±95% confidence intervals of maximum temperature and heating duration from the mechanistic model that also included tree height and flame height. Neither (A) maximum temperature nor (B) heating duration had strong effects on fire survival probability. Predicted curves are plotted over observed data and estimated for with other covariates held at the mean values for the population (tree height = 340 cm, flame height = 94 cm, maximum temperature = 434 ºC, seconds >100 ºC = 105). The points are jittered vertically in both panels to reduce overlap and increase visibility. Temperature metrics are from the 25 cm probe height.	
