Interacting global change drivers suppress a foundation tree species
================
S.L. Flory, W.W. Dillon, D. Hiatt
2022-01-06

-   [Abstract](#abstract)
-   [Figure 1. Treatment effects on
    fire](#figure-1-treatment-effects-on-fire)
-   [Figure 2. Global change drivers and
    mechanisms](#figure-2-global-change-drivers-and-mechanisms)
-   [Figure 3. Management model
    predictions](#figure-3-management-model-predictions)
-   [Supplemental Tables](#supplemental-tables)
    -   [Table S1 Treatment effects on fuel
        loads](#table-s1-treatment-effects-on-fuel-loads)
    -   [Table S2 Flame height model
        summary](#table-s2-flame-height-model-summary)
    -   [Table S3. Maximum temperature models
        summaries](#table-s3-maximum-temperature-models-summaries)
    -   [Table S4. Heating duration models
        summaries](#table-s4-heating-duration-models-summaries)
    -   [Table S5. Summary of treatment and fire
        effects.](#table-s5-summary-of-treatment-and-fire-effects)
    -   [Table S6. Global change model
        summary](#table-s6-global-change-model-summary)
    -   [Table S7. Global change model
        predictions](#table-s7-global-change-model-predictions)
    -   [Table S8. Mechanistic model
        summary](#table-s8-mechanistic-model-summary)
    -   [Table S9. Mechanistic model
        predictions](#table-s9-mechanistic-model-predictions)
    -   [Table S10. Management model
        summary](#table-s10-management-model-summary)
    -   [Table S11. Management model
        summary](#table-s11-management-model-summary)
    -   [Tree height multiple
        comparison](#tree-height-multiple-comparison)
-   [Supplemental Figures](#supplemental-figures)
    -   [Figure S1. Fuel load vs. maximum temperature or heating
        duration at each probe
        height](#figure-s1-fuel-load-vs-maximum-temperature-or-heating-duration-at-each-probe-height)
    -   [Figure S2. Mehanistic model maximum temperature and heating
        duration](#figure-s2-mehanistic-model-maximum-temperature-and-heating-duration)

# Abstract

Ecological stress caused by climate change, invasive species,
anthropogenic disturbance, and other factors is driving global
environmental change. These stressors often occur simultaneously but how
they interact to impact native species is poorly understood. We used a
longer-term (i.e., six years) field experiment to test how two stressors
(drought and invasion by the non-native perennial grass *Imperata
cylindrica*) interacted to determine effects of a third stressor (fire)
on longleaf pine (*Pinus palustris*), the foundation species for a
threatened fire-dependent ecosystem in the Southeast USA. Invasion
resulted in 65% greater fuel loads, causing over four times taller
flames, significantly greater maximum temperatures, and longer heating
duration. Invasion combined with prolonged drought also resulted in
notably shorter trees than invasion alone, and shorter trees are
substantially more vulnerable to mortality due to fire. Consequently,
nearly all tree mortality occurred due to a synergistic interaction
between fire and the drought + invasion treatment, whereby shorter trees
experienced taller flames driven by invasion, resulting in 44% of trees
killed by fire. Given average fuel loads in the experiment, modeling
predicted that 99% of 2 m tall trees would survive in native
vegetation-dominated areas but only 37% of 2 m tall trees would survive
in invaded areas due to more intense fires, highlighting an
ecosystem-wide benefit of invader prevention and removal. These findings
demonstrate that synergy among ecological stressors can result in
dramatic impacts on native species, emphasizing that longer-term,
multi-factorial, manipulative studies are needed to accurately forecast
ecological outcomes of global environmental change.

<!-- Only uses data from plots that had living trees when fire was applied. -->
<!-- # Fuel load model -->
<!-- $$
\operatorname{fuels\_kg} = \alpha + \beta_{1}(\operatorname{Treatment}_{\operatorname{Drought}}) + \beta_{2}(\operatorname{Treatment}_{\operatorname{Invasion}}) + \beta_{3}(\operatorname{Treatment}_{\operatorname{Drought\ +\ Invasion}}) + \epsilon
$$
 -->
<!-- # Flame height model -->
<!-- $$
\operatorname{avg\_flameht\_cm} = \alpha + \beta_{1}(\operatorname{fuels\_kg}) + \beta_{2}(\operatorname{Treatment}_{\operatorname{Drought}}) + \beta_{3}(\operatorname{Treatment}_{\operatorname{Invasion}}) + \beta_{4}(\operatorname{Treatment}_{\operatorname{Drought\ +\ Invasion}}) + \epsilon
$$
 -->
<!-- $$
\operatorname{avg\_flameht\_cm} = \alpha + \beta_{1}(\operatorname{fuels\_kg}) + \beta_{2}(\operatorname{veg\_trt}_{\operatorname{Invasion}}) + \epsilon
$$
 -->
<!-- # Maximum temperature and heating duration models -->

# Figure 1. Treatment effects on fire

![](drought_invasion_fire_files/figure-gfm/Fig1%20treatment%20effects%20on%20fire-1.png)<!-- -->

Effects of drought, invasion, and drought + invasion on fuel loads and
fire behavior. Invasion produced greater fuel loads, which affected
ecologically important aspects of fire behavior. (A) Average fine fuel
loads were 57% greater with invasion than without invasion (means ± SE
over data points for each plot). See Table S1 for model
results. (B) Greater fuel loads produced significantly taller flames,
and flame heights were over four times taller in plots with
invasion. (C) Maximum temperatures at 25 cm above ground were higher in
invasion and increased with fuel load. (D) Heating duration (time above
100 ºC) at 25 cm above ground was longer with invasion but was
unaffected by fuel load. Best fit lines ±95% CI in (B, C, D). Predicted
lines in (D) are the average fuel height of 109 cm across all plots.
Red/dark = invasion, blue/light = no invasion. Point shapes indicate
treatment: square = Reference, triangle = Drought, circle = Invasion,
diamond = Drought + Invasion (Dro + Inv).

<!-- # Global change model -->
<!-- $$
\begin{aligned}
  \operatorname{survival}_{i}  &\sim \operatorname{Binomial}(n = 1, \operatorname{prob}_{\operatorname{survival} = 1} = \widehat{P}) \\
    \log\left[\frac{\hat{P}}{1 - \hat{P}} \right] &=\alpha_{j[i]} + \beta_{1}(\operatorname{tree\_height\_cm}) \\
    \alpha_{j}  &\sim N \left(\gamma_{0}^{\alpha} + \gamma_{1}^{\alpha}(\operatorname{Treatment}_{\operatorname{Drought}}) + \gamma_{2}^{\alpha}(\operatorname{Treatment}_{\operatorname{Invasion}}) + \gamma_{3}^{\alpha}(\operatorname{Treatment}_{\operatorname{Drought\ +\ Invasion}}), \sigma^2_{\alpha_{j}} \right)
    \text{, for Plot j = 1,} \dots \text{,J}
\end{aligned}
$$
 -->
<!-- # Mechanistic model -->
<!-- $$
\begin{aligned}
  \operatorname{survival}_{i}  &\sim \operatorname{Binomial}(n = 1, \operatorname{prob}_{\operatorname{survival} = 1} = \widehat{P}) \\
    \log\left[\frac{\hat{P}}{1 - \hat{P}} \right] &=\alpha_{j[i]} + \beta_{1}(\operatorname{tree\_height\_cm}) \\
    \alpha_{j}  &\sim N \left(\gamma_{0}^{\alpha} + \gamma_{1}^{\alpha}(\operatorname{avg\_flameht\_cm}) + \gamma_{2}^{\alpha}(\operatorname{avg\_max\_tempC}) + \gamma_{3}^{\alpha}(\operatorname{avg\_s\_abv\_100}), \sigma^2_{\alpha_{j}} \right)
    \text{, for Plot j = 1,} \dots \text{,J}
\end{aligned}
$$
 -->

# Figure 2. Global change drivers and mechanisms

![](drought_invasion_fire_files/figure-gfm/Figure%202%20global%20drivers%20and%20mechanisms-1.png)<!-- -->

Mechanistic effects of drought, invasion, and drought + invasion on tree
survival following fires. (A) Trees in the drought + invasion treatment
(diamond) were generally shorter than with invasion alone (circle), and
flames were taller in invaded plots (means ±1 SD of tree height and
flame height for surviving (filled) and dead (open) trees; small points
for individual trees; red/dark = invasion, blue/light = no
invasion). (B) As a result, tree mortality under the drought + invasion
treatment was much higher (44%) than in reference (10%), invasion alone
(10%), or drought alone (no mortality). (C) The model of global change
drivers (drought, invasion) effects on tree survival showed
that fire survival probability was determined by tree height and
invasion, but not drought (dashed line at 100% obscured by points). (D)
Tree height and (E) flame height were significant factors determining
tree survival in the mechanistic model, which also included maximum
temperature and heating duration (but not experimental treatments).
Predicted lines ±95% CI; points on C – E are individual trees
(vertically jittered for visibility), shape indicates plot treatment.

<!-- # Management Model -->
<!-- $$
\begin{aligned}
  \operatorname{survival}_{i}  &\sim \operatorname{Binomial}(n = 1, \operatorname{prob}_{\operatorname{survival} = 1} = \widehat{P}) \\
    \log\left[\frac{\hat{P}}{1 - \hat{P}} \right] &=\alpha_{j[i]} + \beta_{1}(\operatorname{tree\_height\_cm}) \\
    \alpha_{j}  &\sim N \left(\gamma_{0}^{\alpha} + \gamma_{1}^{\alpha}(\operatorname{fuels\_kg}) + \gamma_{2}^{\alpha}(\operatorname{veg\_trt}_{\operatorname{Invasion}}) + \gamma_{3}^{\alpha}(\operatorname{fuels\_kg} \times \operatorname{veg\_trt}_{\operatorname{Invasion}}), \sigma^2_{\alpha_{j}} \right)
    \text{, for Plot j = 1,} \dots \text{,J}
\end{aligned}
$$
 -->

# Figure 3. Management model predictions

![](drought_invasion_fire_files/figure-gfm/Figure%203%20managment%20model-1.png)<!-- -->

Management implications for effects of tree height and fuel load on tree
survival. (A) The predicted effect of tree height (conditioned on
average fuel load across all plots of 0.91 kg m-2) on tree survival was
mediated by invasion, in which trees had to be significantly taller to
survive fire. (B) Greater fuel loads (conditioned on average tree height
across all plots of 340 cm) were predicted to reduce survival with, but
not without invasion. (C, D) Model predictions for 0.6 kg m-2 and 1.2 kg
m-2 fuel loads underscored strong invader effects on tree survival
probability across tree heights. Lines and shading are predicted means
±95% CI. Points are individual trees and shape indicates plot treatment.
Red/dark = invasion, blue/light = no invasion.

# Supplemental Tables

## Table S1 Treatment effects on fuel loads

| Term                        | Estimate |    SE | t-value | P-value |
|:----------------------------|---------:|------:|--------:|--------:|
| (Intercept)                 |    0.733 | 0.090 |   8.142 |   0.000 |
| TreatmentDrought            |    0.043 | 0.135 |   0.315 |   0.755 |
| TreatmentInvasion           |    0.358 | 0.147 |   2.439 |   0.021 |
| TreatmentDrought + Invasion |    0.507 | 0.135 |   3.756 |   0.001 |

Model results for treatment effects on average fuel loads relative to
the Reference plots (adjusted R2 = 0.33). Note that we only included
fuel load data for plots with trees in them at the time of the fires (N
= 32 plots. Reference = 10, Invasion = 6, Drought = 8, Drought +
Invasion = 8).

## Table S2 Flame height model summary

| Term                        | Estimate |     SE | t-value | P-value |
|:----------------------------|---------:|-------:|--------:|--------:|
| (Intercept)                 |   -9.073 | 18.493 |  -0.491 |   0.628 |
| fuels\_kg                   |   68.365 | 21.157 |   3.231 |   0.003 |
| TreatmentDrought            |    8.185 | 15.142 |   0.541 |   0.593 |
| TreatmentInvasion           |  112.933 | 18.119 |   6.233 |   0.000 |
| TreatmentDrought + Invasion |  122.422 | 18.537 |   6.604 |   0.000 |

Coefficient estimates and p-values for the model of flame height
affected by treatment (adjusted R2 = 0.84). Best fit lines in Fig. 1B
are a simplified model of no invasion (Reference, Drought) versus
invasion (Invasion, Drought + Invasion)

## Table S3. Maximum temperature models summaries

| probe\_ht | term             | estimate | std.error | statistic | p.value | adj.r2 |
|:----------|:-----------------|---------:|----------:|----------:|--------:|:-------|
| 50 cm     | (Intercept)      |   76.374 |    51.491 |     1.483 |   0.149 | 0.76   |
| 50 cm     | fuels\_kg        |  214.559 |    61.724 |     3.476 |   0.002 | 0.76   |
| 50 cm     | veg\_trtInvasion |  228.009 |    42.716 |     5.338 |   0.000 | 0.76   |
| 25 cm     | (Intercept)      |  136.095 |    70.385 |     1.934 |   0.063 | 0.54   |
| 25 cm     | fuels\_kg        |  285.920 |    84.373 |     3.389 |   0.002 | 0.54   |
| 25 cm     | veg\_trtInvasion |  121.011 |    58.390 |     2.072 |   0.047 | 0.54   |
| 0 cm      | (Intercept)      |  238.915 |    56.037 |     4.263 |   0.000 | 0.44   |
| 0 cm      | fuels\_kg        |  302.898 |    67.174 |     4.509 |   0.000 | 0.44   |
| 0 cm      | veg\_trtInvasion |  -36.777 |    46.488 |    -0.791 |   0.435 | 0.44   |

Coefficient estimates and adjusted R2 for models of maximum temperature
at each probe height. Results are illustrated in Fig. S1.

## Table S4. Heating duration models summaries

| probe\_ht | term              | estimate | std.error | statistic | p.value | adj.r2 |
|:----------|:------------------|---------:|----------:|----------:|--------:|:-------|
| 50 cm     | (Intercept)       |   66.629 |    11.761 |     5.665 |   0.000 | 0.5    |
| 50 cm     | fuels\_kg         |   27.943 |    12.004 |     2.328 |   0.027 | 0.5    |
| 50 cm     | veg\_trtInvasion  |   35.326 |     9.802 |     3.604 |   0.001 | 0.5    |
| 50 cm     | avg\_fuel\_ht\_cm |   -0.837 |     0.313 |    -2.673 |   0.012 | 0.5    |
| 25 cm     | (Intercept)       |  120.851 |    16.254 |     7.435 |   0.000 | 0.09   |
| 25 cm     | fuels\_kg         |   -4.033 |    16.590 |    -0.243 |   0.810 | 0.09   |
| 25 cm     | veg\_trtInvasion  |   28.633 |    13.548 |     2.114 |   0.044 | 0.09   |
| 25 cm     | avg\_fuel\_ht\_cm |   -0.923 |     0.433 |    -2.133 |   0.042 | 0.09   |
| 0 cm      | (Intercept)       |  167.933 |    23.865 |     7.037 |   0.000 | 0.11   |
| 0 cm      | fuels\_kg         |   -9.637 |    24.358 |    -0.396 |   0.695 | 0.11   |
| 0 cm      | veg\_trtInvasion  |   27.731 |    19.890 |     1.394 |   0.174 | 0.11   |
| 0 cm      | avg\_fuel\_ht\_cm |   -1.553 |     0.636 |    -2.444 |   0.021 | 0.11   |

Coefficient estimates and adjusted R2 for models of heating duration
(seconds above 100 ºC) at each probe height. Results are illustrated in
Fig. S1

## Table S5. Summary of treatment and fire effects.

| Treatment          | plots | trees | treatment\_effect\_pct | dead | alive | fire\_effect\_pct | avg\_height | sd\_height | pct\_survival | sd\_pct\_survival |
|:-------------------|------:|------:|-----------------------:|-----:|------:|------------------:|------------:|-----------:|--------------:|------------------:|
| Reference          |    10 |    75 |                    0.0 |    7 |    68 |              -9.3 |       305.6 |      188.0 |          90.7 |              29.3 |
| Drought            |     8 |    30 |                   60.0 |    0 |    30 |               0.0 |       382.3 |      156.4 |         100.0 |               0.0 |
| Invasion           |     6 |    19 |                   74.7 |    2 |    17 |             -10.5 |       453.8 |      150.2 |          89.5 |              31.5 |
| Drought + Invasion |     8 |    32 |                   57.3 |   14 |    18 |             -43.8 |       313.2 |      159.0 |          56.2 |              50.4 |

Summary of treatment and fire effects, tree height, and proportion
survival in each treatment group. Treatment effect pre-fire is number of
trees alive under each treatment relative to the number of trees in the
Reference plots. Fire effect is number of trees alive after fires
relative to before fires. Standard deviations (SD) of height calculated
across trees and SD of survival estimated across plots.

## Table S6. Global change model summary

| Term                        | Estimated OR | conf.low | conf.high | P-value |
|:----------------------------|-------------:|---------:|----------:|--------:|
| tree\_height\_cm            |        1.023 |    1.008 |     1.038 |   0.003 |
| TreatmentDrought            | 62582049.329 |    0.000 |       Inf |   0.983 |
| TreatmentInvasion           |        0.012 |    0.000 |     0.716 |   0.034 |
| TreatmentDrought + Invasion |        0.003 |    0.000 |     0.180 |   0.006 |

The estimates for the treatment terms are in comparison to the
“Reference” treatment (no invasion or drought). Model term, estimated
odds-ratio (OR), 95% confidence interval (CI) of the OR, P-value of the
estimate. Model predictions are illustrated in Figure 2C.

## Table S7. Global change model predictions

| tree\_height\_cm | surv\_probability | conf.low | conf.high | Treatment          |
|-----------------:|------------------:|---------:|----------:|:-------------------|
|               70 |              0.75 |     0.44 |      0.92 | Reference          |
|               70 |              1.00 |     0.00 |      1.00 | Drought            |
|               70 |              0.04 |     0.00 |      0.59 | Invasion           |
|               70 |              0.01 |     0.00 |      0.25 | Drought + Invasion |
|              150 |              0.95 |     0.71 |      0.99 | Reference          |
|              150 |              1.00 |     0.00 |      1.00 | Drought            |
|              150 |              0.18 |     0.01 |      0.80 | Invasion           |
|              150 |              0.04 |     0.00 |      0.40 | Drought + Invasion |
|              270 |              1.00 |     0.89 |      1.00 | Reference          |
|              270 |              1.00 |     0.00 |      1.00 | Drought            |
|              270 |              0.76 |     0.19 |      0.98 | Invasion           |
|              270 |              0.40 |     0.13 |      0.75 | Drought + Invasion |
|              340 |              1.00 |     0.93 |      1.00 | Reference          |
|              340 |              1.00 |     0.00 |      1.00 | Drought            |
|              340 |              0.94 |     0.45 |      1.00 | Invasion           |
|              340 |              0.76 |     0.42 |      0.93 | Drought + Invasion |

Predicted tree survival probability following fire from the global
change model for specific values of tree height under each treatment.

## Table S8. Mechanistic model summary

| term          | estimate | conf.low | conf.high | p.value |
|:--------------|---------:|---------:|----------:|--------:|
| Tree ht (cm)  |    1.023 |    1.007 |     1.039 |   0.006 |
| Flame ht (cm) |    0.969 |    0.948 |     0.991 |   0.006 |
| Max temp (ºC) |    0.995 |    0.987 |     1.003 |   0.210 |
| s &gt;100 ºC  |    1.004 |    0.973 |     1.036 |   0.795 |

Mechanistic model summary. Term, estimated odds ratio (OR), 95%
confidence interval of the OR, P-value of the estimate. Model
predictions are illustrated in Figures 2D, E, and S2.

## Table S9. Mechanistic model predictions

| Tree height (cm) | % survival probability | conf.low | conf.high | Flame height (cm) |
|-----------------:|-----------------------:|---------:|----------:|:------------------|
|              100 |                   0.79 |     0.53 |      0.93 | 50                |
|              200 |                   0.97 |     0.81 |      1.00 | 50                |
|              300 |                   1.00 |     0.91 |      1.00 | 50                |
|              400 |                   1.00 |     0.95 |      1.00 | 50                |
|              100 |                   0.45 |     0.20 |      0.72 | 100               |
|              200 |                   0.89 |     0.67 |      0.97 | 100               |
|              300 |                   0.99 |     0.83 |      1.00 | 100               |
|              400 |                   1.00 |     0.91 |      1.00 | 100               |
|              100 |                   0.03 |     0.00 |      0.40 | 200               |
|              200 |                   0.25 |     0.05 |      0.69 | 200               |
|              300 |                   0.77 |     0.32 |      0.96 | 200               |
|              400 |                   0.97 |     0.61 |      1.00 | 200               |

Mechanistic model predictions. Predicted tree survival probability from
the mechanistic model for specific values of tree height and flame
height. Predictions are for the mean values of maximum temperature (434
ºC) and heating duration (105 seconds).

## Table S10. Management model summary

| Term                | Estimated OR | conf.low | conf.high | P-value |
|:--------------------|-------------:|---------:|----------:|--------:|
| Tree ht (cm)        |       1.0289 |   1.0132 |    1.0447 |  0.0003 |
| Fuel load (kg)      |       0.4720 |   0.0366 |    6.0919 |  0.5651 |
| Invasion            |       0.8654 |   0.0072 |  103.9183 |  0.9528 |
| Fuel load\*Invasion |       0.0032 |   0.0000 |    0.5481 |  0.0285 |

Management model summary. Term, estimated odds ratio (OR), 95%
confidence interval of the OR, P-value of the estimate. Model
predictions are illustrated in Figure 3.

## Table S11. Management model summary

| Tree height (cm) | % survival probability | conf.low | conf.high | Group       | Fuel load       |
|-----------------:|-----------------------:|---------:|----------:|:------------|:----------------|
|               10 |                   0.42 |     0.15 |      0.76 | No invasion | fuels\_kg = 0.6 |
|               10 |                   0.02 |     0.00 |      0.38 | Invasion    | fuels\_kg = 0.6 |
|               50 |                   0.70 |     0.39 |      0.89 | No invasion | fuels\_kg = 0.6 |
|               50 |                   0.06 |     0.00 |      0.55 | Invasion    | fuels\_kg = 0.6 |
|              100 |                   0.90 |     0.69 |      0.98 | No invasion | fuels\_kg = 0.6 |
|              100 |                   0.21 |     0.02 |      0.77 | Invasion    | fuels\_kg = 0.6 |
|              200 |                   0.99 |     0.93 |      1.00 | No invasion | fuels\_kg = 0.6 |
|              200 |                   0.82 |     0.33 |      0.98 | Invasion    | fuels\_kg = 0.6 |
|              300 |                   1.00 |     0.98 |      1.00 | No invasion | fuels\_kg = 0.6 |
|              300 |                   0.99 |     0.81 |      1.00 | Invasion    | fuels\_kg = 0.6 |
|              400 |                   1.00 |     1.00 |      1.00 | No invasion | fuels\_kg = 0.6 |
|              400 |                   1.00 |     0.96 |      1.00 | Invasion    | fuels\_kg = 0.6 |
|               10 |                   0.37 |     0.15 |      0.66 | No invasion | fuels\_kg = 0.9 |
|               10 |                   0.00 |     0.00 |      0.11 | Invasion    | fuels\_kg = 0.9 |
|               50 |                   0.65 |     0.41 |      0.83 | No invasion | fuels\_kg = 0.9 |
|               50 |                   0.01 |     0.00 |      0.18 | Invasion    | fuels\_kg = 0.9 |
|              100 |                   0.88 |     0.70 |      0.96 | No invasion | fuels\_kg = 0.9 |
|              100 |                   0.04 |     0.00 |      0.33 | Invasion    | fuels\_kg = 0.9 |
|              200 |                   0.99 |     0.92 |      1.00 | No invasion | fuels\_kg = 0.9 |
|              200 |                   0.39 |     0.12 |      0.75 | Invasion    | fuels\_kg = 0.9 |
|              300 |                   1.00 |     0.98 |      1.00 | No invasion | fuels\_kg = 0.9 |
|              300 |                   0.92 |     0.67 |      0.98 | Invasion    | fuels\_kg = 0.9 |
|              400 |                   1.00 |     0.99 |      1.00 | No invasion | fuels\_kg = 0.9 |
|              400 |                   0.99 |     0.92 |      1.00 | Invasion    | fuels\_kg = 0.9 |
|               10 |                   0.32 |     0.10 |      0.65 | No invasion | fuels\_kg = 1.2 |
|               10 |                   0.00 |     0.00 |      0.04 | Invasion    | fuels\_kg = 1.2 |
|               50 |                   0.59 |     0.30 |      0.83 | No invasion | fuels\_kg = 1.2 |
|               50 |                   0.00 |     0.00 |      0.06 | Invasion    | fuels\_kg = 1.2 |
|              100 |                   0.86 |     0.60 |      0.96 | No invasion | fuels\_kg = 1.2 |
|              100 |                   0.01 |     0.00 |      0.12 | Invasion    | fuels\_kg = 1.2 |
|              200 |                   0.99 |     0.89 |      1.00 | No invasion | fuels\_kg = 1.2 |
|              200 |                   0.09 |     0.01 |      0.37 | Invasion    | fuels\_kg = 1.2 |
|              300 |                   1.00 |     0.97 |      1.00 | No invasion | fuels\_kg = 1.2 |
|              300 |                   0.62 |     0.35 |      0.83 | Invasion    | fuels\_kg = 1.2 |
|              400 |                   1.00 |     0.99 |      1.00 | No invasion | fuels\_kg = 1.2 |
|              400 |                   0.97 |     0.80 |      0.99 | Invasion    | fuels\_kg = 1.2 |

Table S11. Management model predictions. Average survival probability
with or without invasion across a range of tree heights for three
different fuel loads.

## Tree height multiple comparison

| Treatment          | nobs | avg\_ht |    sd |
|:-------------------|-----:|--------:|------:|
| Reference          |   75 |   305.6 | 188.0 |
| Drought            |   30 |   382.3 | 156.4 |
| Invasion           |   19 |   453.8 | 150.2 |
| Drought + Invasion |   32 |   313.2 | 159.0 |

Average tree height

    ## Analysis of Deviance Table (Type II Wald F tests with Kenward-Roger df)
    ## 
    ## Response: tree_height_cm
    ##                F Df Df.res  Pr(>F)  
    ## Treatment 3.0838  3 24.195 0.04624 *
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

![](drought_invasion_fire_files/figure-gfm/tree%20height%20model-1.png)<!-- -->
<table style="border-collapse:collapse; border:none;">
<tr>
<th style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm;  text-align:left; ">
 
</th>
<th colspan="3" style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm; ">
tree\_height\_cm
</th>
</tr>
<tr>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  text-align:left; ">
Predictors
</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">
Estimates
</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">
CI
</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">
p
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
(Intercept)
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
303.98
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
252.68 – 355.28
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
<strong>&lt;0.001
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
Treatment \[Drought\]
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
71.34
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-20.65 – 163.32
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.129
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
Treatment \[Invasion\]
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
143.88
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
41.56 – 246.21
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
<strong>0.006</strong>
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">
Treatment \[Drought +<br>Invasion\]
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-1.25
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
-89.72 – 87.22
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">
0.978
</td>
</tr>
<tr>
<td colspan="4" style="font-weight:bold; text-align:left; padding-top:.8em;">
Random Effects
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">
σ<sup>2</sup>
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="3">
27139.59
</td>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">
τ<sub>00</sub> <sub>Plot</sub>
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="3">
2874.47
</td>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">
ICC
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="3">
0.10
</td>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">
N <sub>Plot</sub>
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="3">
32
</td>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm; border-top:1px solid;">
Observations
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left; border-top:1px solid;" colspan="3">
156
</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">
Marginal R<sup>2</sup> / Conditional R<sup>2</sup>
</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="3">
0.078 / 0.167
</td>
</tr>
</table>

    ## 
    ##   Simultaneous Tests for General Linear Hypotheses
    ## 
    ## Multiple Comparisons of Means: Tukey Contrasts
    ## 
    ## 
    ## Fit: lmer(formula = tree_height_cm ~ Treatment + (1 | Plot), data = dat25cm)
    ## 
    ## Linear Hypotheses:
    ##                                     Estimate Std. Error z value Pr(>|z|)  
    ## Drought - Reference == 0              71.339     46.932   1.520   0.4210  
    ## Invasion - Reference == 0            143.882     52.208   2.756   0.0294 *
    ## Drought + Invasion - Reference == 0   -1.251     45.140  -0.028   1.0000  
    ## Invasion - Drought == 0               72.544     59.652   1.216   0.6125  
    ## Drought + Invasion - Drought == 0    -72.589     53.575  -1.355   0.5235  
    ## Drought + Invasion - Invasion == 0  -145.133     58.252  -2.491   0.0599 .
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## (Adjusted p values reported -- single-step method)

    ##          Reference            Drought           Invasion Drought + Invasion 
    ##                "a"               "ab"                "b"               "ab"

# Supplemental Figures

## Figure S1. Fuel load vs. maximum temperature or heating duration at each probe height

![](drought_invasion_fire_files/figure-gfm/Figure%20S1%20max%20temp%20heating%20duration-1.png)<!-- -->

Best fit lines ±95% confidence intervals (shaded) illustrating the
relationship between fuel load and maximum temperatures (A) or heating
duration (B) at each probe height above ground level (0 cm, 25 cm, and
50 cm). Data points are shown for the three sensors at each height in
each plot to illustrate variation in the fire behavior. Predictions of
heating duration (seconds above 100 ºC) are for the mean fuel height
value across all plots (109 cm). Red/dark = invasion, blue/light = no
invasion.

## Figure S2. Mehanistic model maximum temperature and heating duration

![](drought_invasion_fire_files/figure-gfm/Figure%20S2%20mech_model_supp_fig-1.png)<!-- -->

Estimated effects ±95% confidence intervals of maximum temperature and
heating duration from the mechanistic model that also included tree
height and flame height. Neither (A) maximum temperature nor (B) heating
duration had strong effects on fire survival probability. Predicted
curves are plotted over observed data and estimated for with other
covariates held at the mean values for the population (tree height = 340
cm, flame height = 94 cm, maximum temperature = 434 ºC, seconds &gt;100
ºC = 105). The points are jittered vertically in both panels to reduce
overlap and increase visibility. Temperature metrics are from the 25 cm
probe height.
