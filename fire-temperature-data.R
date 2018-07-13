## Fire temperature processing ----

## load packages ----
library(plyr)
library(dplyr)
library(readr)
library(stringr)
library(ggplot2)

## read in temperature data ----
# 3 loggers were in each flame height sensor box (near ground, 25cm, 50cm)
# temperature was recorded continuously and the sensor box was moved to next plot
# 12 boxes, 36 sensors, so 36 files to process

# Goal: add a plot id and probe location to each fire

flist <- list.files("data/temperature_data_raw/", pattern = ".csv", full.names = T)
# nlist <- list.files("data/temperature_data_raw/", pattern = ".csv")
# df_name <- str_split(flist, "[_/]")

# d <- flist[1]
# d <- (str_split(d, "[_/]"))
# d <- unlist(d)
# dname = d[6]
temps_data <- data.frame()
for(fname in flist){
  
  df_name = str_split(fname, "[_/]")
  df_name = unlist(df_name)
  location = df_name[7]
  box_num = df_name[6]
  df = read_csv(fname)
  df = df[,1:3]
  
  if (names(df)[2]=="Time, GMT-05:00") {
    df[,2] = df[,2]+3600
  }
  
  names(df) = c("date","time","probe_tempC")
  df = mutate(df, temp_ht = paste(location),
              box_number = paste(box_num))
  temps_data = rbind(temps_data, df)
  
  # assign(paste(df_name[6],"_",df_name[7], sep = ""))
  # rm(df)
}



