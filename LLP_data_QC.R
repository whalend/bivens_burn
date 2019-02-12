# Data QC on longleaf pine 

library(plyr)
library(dplyr)
library(readxl)
library(readr)

tree_survival <- read_excel("data/LL_Surv_Ht Diam_2018_cathy_fixed.xlsx")
# summary(tree_survival)

tree_survival <- tree_survival %>% 
  rename(dead_limbs = dead,
         total_limbs = total,
         dbh_cm = DBH,
         chart_ht_cm = Char) %>% 
  mutate(ht1_cm = as.numeric(Ht_m_before_burn)*100,
         ht2_cm = as.numeric(ht_cm_after_burn),
         diam1_mm = as.numeric(Diam_mm_before_burn),
         diam2_mm = as.numeric(diam_cm_after_burn*10),
         pct_brown = as.numeric(`% brown`),
         pct_brown = ifelse(is.na(pct_brown), .5, pct_brown),
         pct_dead_limbs = 100*(dead_limbs/total_limbs),
         dbh_cm = as.numeric(dbh_cm)
  ) %>% 
  filter(!is.na(ht2_cm)) %>% 
  select(Block:Ind., dead_limbs:chart_ht_cm, dbh_cm, ht1_cm:pct_dead_limbs)
# summary(tree_survival)

## Fixed transcription errors in the orginal datasheet
# filter(tree_survival, pct_dead_limbs>100)
# filter(tree_survival, is.na(diam2_mm))
tree_survival$diam2_mm[is.na(tree_survival$diam2_mm)] <- tree_survival$diam1_mm[is.na(tree_survival$diam2_mm)]

# hist(tree_survival$total_limbs)
# filter(tree_survival, total_limbs>20)

tree_survival$dead_limbs[tree_survival$total_limbs==73] <- 6
tree_survival$total_limbs[tree_survival$total_limbs==73] <- 13

# hist(tree_survival$dbh_cm)
# filter(tree_survival, dbh_cm>10)
tree_survival$dbh_cm[tree_survival$dbh_cm>10] <- 3.6
# summary(tree_survival)

write_csv(tree_survival, "data/LLP_Surv_2018_corrected.csv")
