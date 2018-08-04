## Fire temperature processing ----

## load packages ----
library(plyr)
library(dplyr)
library(readr)
library(readxl)
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
  df = mutate(df, probe_ht = paste(location),
              box_number = paste(box_num))
  temps_data = rbind(temps_data, df)
  
  # assign(paste(df_name[6],"_",df_name[7], sep = ""))
  rm(df)
}

ignition_times <- read_csv("data/ignition_times.csv")
# ignition_times
names(ignition_times) <- c("plot_num","ignition_time")

box_locations <- read_excel("data/FlameHts.xlsx")
# box_locations
# names(box_locations) <- c("plot_num","location","box_number")
box_locations <- box_locations %>% 
  select(plot_num = Plot, location = Location, box_number = Box_ID) %>% 
  mutate(box_number = paste("box",box_number, sep=""))


fire_plot_info <- left_join(
  box_locations,
  ignition_times
)
fire_plot_info$time_numeric <- as.numeric(fire_plot_info$ignition_time)

# left_join(temps_data, fire_plot_info,
#           by = c("box_number","time"="ignition_time"))

# iteration = 1
# temps_data$plot_num <- "NULL"
# temps_data$location <- "NULL"
# 
temps_data$plot_num <- NA
temps_data$location <- NA

t_data <- (filter(temps_data, between(time,38000,60960), probe_tempC>35))

ggplot(filter(t_data, probe_ht=="0cm", box_number=="box1"), 
              aes(time, probe_tempC)) +
         geom_path()


# system.time(
# for (m in 1:nrow(t_data[1:100,])) {
#   # print(n)
#   for (n in 1:nrow(fire_plot_info)) {
#     if (is.na(t_data[m,6]==TRUE) & t_data[m,2] < ((fire_plot_info[n,5]+600)) & fire_plot_info[n,3]==t_data[m,5]) {
#       
#       t_data$plot_num[m] = fire_plot_info$plot_num[n]
#       t_data$location[m] = fire_plot_info$location[n]
#       
#     } else{}
#   }
#   # print(m)
# }
# )


unique(t_data$plot_num)

# filter(temps_data, between(time, 38400, 40940) & box_number=="box1")


# Assign plot numbers and location IDs to temperatures ----
# Box 1 ----
filter(fire_plot_info, box_number=="box1")

temps_data$plot_num[temps_data$box_number=="box1" & between(temps_data$time, 38400, 40940)] <- 4
temps_data$location[temps_data$box_number=="box1" & between(temps_data$time, 38400, 40940)] <- "C"

temps_data$plot_num[temps_data$box_number=="box1" & between(temps_data$time, 41040, 43400)] <- 8
temps_data$location[temps_data$box_number=="box1" & between(temps_data$time, 41040, 43400)] <- "C"

temps_data$plot_num[temps_data$box_number=="box1" & between(temps_data$time, 43500, 45980)] <- 12
temps_data$location[temps_data$box_number=="box1" & between(temps_data$time, 43500, 45980)] <- "C"

temps_data$plot_num[temps_data$box_number=="box1" & between(temps_data$time, 46080, 49160)] <- 16
temps_data$location[temps_data$box_number=="box1" & between(temps_data$time, 46080, 49160)] <- "B"

temps_data$plot_num[temps_data$box_number=="box1" & between(temps_data$time, 49260, 52220)] <- 20
temps_data$location[temps_data$box_number=="box1" & between(temps_data$time, 49260, 52220)] <- "A"

temps_data$plot_num[temps_data$box_number=="box1" & between(temps_data$time, 52320, 53840)] <- 24
temps_data$location[temps_data$box_number=="box1" & between(temps_data$time, 52320, 53840)] <- "B"

temps_data$plot_num[temps_data$box_number=="box1" & between(temps_data$time, 53940, 55760)] <- 28
temps_data$location[temps_data$box_number=="box1" & between(temps_data$time, 53940, 55760)] <- "A"

temps_data$plot_num[temps_data$box_number=="box1" & between(temps_data$time, 55860, 57800)] <- 32
temps_data$location[temps_data$box_number=="box1" & between(temps_data$time, 55860, 57800)] <- "B"

temps_data$plot_num[temps_data$box_number=="box1" & between(temps_data$time, 57900, 59720)] <- 36
temps_data$location[temps_data$box_number=="box1" & between(temps_data$time, 57900, 59720)] <- "A"

temps_data$plot_num[temps_data$box_number=="box1" & temps_data$time >= 59820] <- 40
temps_data$location[temps_data$box_number=="box1" & temps_data$time >= 59820] <- "A"


# Box 2 ----
filter(fire_plot_info, box_number=="box2")

temps_data$plot_num[temps_data$box_number=="box2" & between(temps_data$time, 38640, 41360)] <- 2
temps_data$location[temps_data$box_number=="box2" & between(temps_data$time, 38640, 41360)] <- "B"

temps_data$plot_num[temps_data$box_number=="box2" & between(temps_data$time, 41460, 43700)] <- 6
temps_data$location[temps_data$box_number=="box2" & between(temps_data$time, 41460, 43700)] <- "B"

temps_data$plot_num[temps_data$box_number=="box2" & between(temps_data$time, 43800, 46280)] <- 10
temps_data$location[temps_data$box_number=="box2" & between(temps_data$time, 43800, 46280)] <- "B"

temps_data$plot_num[temps_data$box_number=="box2" & between(temps_data$time, 46380, 49520)] <- 14
temps_data$location[temps_data$box_number=="box2" & between(temps_data$time, 46380, 49520)] <- "A"

temps_data$plot_num[temps_data$box_number=="box2" & between(temps_data$time, 49620, 52340)] <- 18
temps_data$location[temps_data$box_number=="box2" & between(temps_data$time, 49620, 52340)] <- "B"

temps_data$plot_num[temps_data$box_number=="box2" & between(temps_data$time, 52440, 54020)] <- 22
temps_data$location[temps_data$box_number=="box2" & between(temps_data$time, 52440, 54020)] <- "B"

temps_data$plot_num[temps_data$box_number=="box2" & between(temps_data$time, 54120, 55820)] <- 26
temps_data$location[temps_data$box_number=="box2" & between(temps_data$time, 54120, 55820)] <- "B"

temps_data$plot_num[temps_data$box_number=="box2" & between(temps_data$time, 55920, 57920)] <- 30
temps_data$location[temps_data$box_number=="box2" & between(temps_data$time, 55920, 57920)] <- "B"

temps_data$plot_num[temps_data$box_number=="box2" & between(temps_data$time, 58020, 59900)] <- 34
temps_data$location[temps_data$box_number=="box2" & between(temps_data$time, 58020, 59900)] <- "C"

temps_data$plot_num[temps_data$box_number=="box2" & temps_data$time>=60000] <- 38
temps_data$location[temps_data$box_number=="box2" & temps_data$time>=60000] <- "A"

# Box 3 ----
filter(fire_plot_info, box_number=="box3")

temps_data$plot_num[temps_data$box_number=="box3" & between(temps_data$time, 38520, 41180)] <- 3
temps_data$location[temps_data$box_number=="box3" & between(temps_data$time, 38520, 41180)] <- "A"

temps_data$plot_num[temps_data$box_number=="box3" & between(temps_data$time, 41280, 43580)] <- 7
temps_data$location[temps_data$box_number=="box3" & between(temps_data$time, 41280, 43580)] <- "B"

temps_data$plot_num[temps_data$box_number=="box3" & between(temps_data$time, 43680, 46100)] <- 11
temps_data$location[temps_data$box_number=="box3" & between(temps_data$time, 43680, 46100)] <- "B"

temps_data$plot_num[temps_data$box_number=="box3" & between(temps_data$time, 46200, 49340)] <- 15
temps_data$location[temps_data$box_number=="box3" & between(temps_data$time, 46200, 49340)] <- "C"

temps_data$plot_num[temps_data$box_number=="box3" & between(temps_data$time, 49440, 52120)] <- 19
temps_data$location[temps_data$box_number=="box3" & between(temps_data$time, 49440, 52120)] <- "C"

temps_data$plot_num[temps_data$box_number=="box3" & between(temps_data$time, 52320, 53960)] <- 23
temps_data$location[temps_data$box_number=="box3" & between(temps_data$time, 52320, 53960)] <- "B"

temps_data$plot_num[temps_data$box_number=="box3" & between(temps_data$time, 54060, 55820)] <- 27
temps_data$location[temps_data$box_number=="box3" & between(temps_data$time, 54060, 55820)] <- "C"

temps_data$plot_num[temps_data$box_number=="box3" & between(temps_data$time, 55920, 57920)] <- 31
temps_data$location[temps_data$box_number=="box3" & between(temps_data$time, 55920, 57920)] <- "A"

temps_data$plot_num[temps_data$box_number=="box3" & between(temps_data$time, 58020, 59780)] <- 35
temps_data$location[temps_data$box_number=="box3" & between(temps_data$time, 58020, 59780)] <- "A"

temps_data$plot_num[temps_data$box_number=="box3" & temps_data$time>59880] <-39
temps_data$location[temps_data$box_number=="box3" & temps_data$time>59880] <-"B"

# Box 4 ----
filter(fire_plot_info, box_number=="box4")

temps_data$plot_num[temps_data$box_number=="box4" & between(temps_data$time, 38400, 40940)] <- 4
temps_data$location[temps_data$box_number=="box4" & between(temps_data$time, 38400, 40940)] <- "A"

temps_data$plot_num[temps_data$box_number=="box4" & between(temps_data$time, 41040, 43400)] <- 8
temps_data$location[temps_data$box_number=="box4" & between(temps_data$time, 41040, 43400)] <- "B"

temps_data$plot_num[temps_data$box_number=="box4" & between(temps_data$time, 43500, 45980)] <- 12
temps_data$location[temps_data$box_number=="box4" & between(temps_data$time, 43500, 45980)] <- "B"

temps_data$plot_num[temps_data$box_number=="box4" & between(temps_data$time, 46080, 49160)] <- 16
temps_data$location[temps_data$box_number=="box4" & between(temps_data$time, 46080, 49160)] <- "C"

temps_data$plot_num[temps_data$box_number=="box4" & between(temps_data$time, 49260, 52220)] <- 20
temps_data$location[temps_data$box_number=="box4" & between(temps_data$time, 49260, 52220)] <- "C"

temps_data$plot_num[temps_data$box_number=="box4" & between(temps_data$time, 52320, 53840)] <- 24
temps_data$location[temps_data$box_number=="box4" & between(temps_data$time, 52320, 53840)] <- "A"

temps_data$plot_num[temps_data$box_number=="box4" & between(temps_data$time, 53940, 55760)] <- 28
temps_data$location[temps_data$box_number=="box4" & between(temps_data$time, 53940, 55760)] <- "B"

temps_data$plot_num[temps_data$box_number=="box4" & between(temps_data$time, 55860, 57800)] <- 32
temps_data$location[temps_data$box_number=="box4" & between(temps_data$time, 55860, 57800)] <- "A"

temps_data$plot_num[temps_data$box_number=="box4" & between(temps_data$time, 57900, 59720)] <- 36
temps_data$location[temps_data$box_number=="box4" & between(temps_data$time, 57900, 59720)] <- "B"

temps_data$plot_num[temps_data$box_number=="box4" & temps_data$time>=59820] <- 40
temps_data$location[temps_data$box_number=="box4" & temps_data$time>=59820] <- "C"

# Box 5 ----
filter(fire_plot_info, box_number=="box5")

temps_data$plot_num[temps_data$box_number=="box5" & between(temps_data$time, 38520, 41180)] <- 3
temps_data$location[temps_data$box_number=="box5" & between(temps_data$time, 38520, 41180)] <- "C"

temps_data$plot_num[temps_data$box_number=="box5" & between(temps_data$time, 41280, 43580)] <- 7
temps_data$location[temps_data$box_number=="box5" & between(temps_data$time, 41280, 43580)] <- "A"

temps_data$plot_num[temps_data$box_number=="box5" & between(temps_data$time, 43680, 46100)] <- 11
temps_data$location[temps_data$box_number=="box5" & between(temps_data$time, 43680, 46100)] <- "A"

temps_data$plot_num[temps_data$box_number=="box5" & between(temps_data$time, 46200, 49340)] <- 15
temps_data$location[temps_data$box_number=="box5" & between(temps_data$time, 46200, 49340)] <- "B"

temps_data$plot_num[temps_data$box_number=="box5" & between(temps_data$time, 49440, 52220)] <- 19
temps_data$location[temps_data$box_number=="box5" & between(temps_data$time, 49440, 52220)] <- "A"

temps_data$plot_num[temps_data$box_number=="box5" & between(temps_data$time, 52320, 53960)] <- 23
temps_data$location[temps_data$box_number=="box5" & between(temps_data$time, 52320, 53960)] <- "C"

temps_data$plot_num[temps_data$box_number=="box5" & between(temps_data$time, 54060, 55820)] <- 27
temps_data$location[temps_data$box_number=="box5" & between(temps_data$time, 54060, 55820)] <- "A"

temps_data$plot_num[temps_data$box_number=="box5" & between(temps_data$time, 55920, 57920)] <- 31
temps_data$location[temps_data$box_number=="box5" & between(temps_data$time, 55920, 57920)] <- "B"

temps_data$plot_num[temps_data$box_number=="box5" & between(temps_data$time, 58020, 59780)] <- 35
temps_data$location[temps_data$box_number=="box5" & between(temps_data$time, 58020, 59780)] <- "B"

temps_data$plot_num[temps_data$box_number=="box5" & temps_data$time>=59880] <- 39
temps_data$location[temps_data$box_number=="box5" & temps_data$time>=59880] <- "C"

# Box 6 ----
filter(fire_plot_info, box_number=="box6")

temps_data$plot_num[temps_data$box_number=="box6" & between(temps_data$time, 38640, 41360)] <- 2
temps_data$location[temps_data$box_number=="box6" & between(temps_data$time, 38640, 41360)] <- "A"

temps_data$plot_num[temps_data$box_number=="box6" & between(temps_data$time, 41460, 43700)] <- 6
temps_data$location[temps_data$box_number=="box6" & between(temps_data$time, 41460, 43700)] <- "A"

temps_data$plot_num[temps_data$box_number=="box6" & between(temps_data$time, 43800, 46280)] <- 10
temps_data$location[temps_data$box_number=="box6" & between(temps_data$time, 43800, 46280)] <- "A"

temps_data$plot_num[temps_data$box_number=="box6" & between(temps_data$time, 46380, 49520)] <- 14
temps_data$location[temps_data$box_number=="box6" & between(temps_data$time, 46380, 49520)] <- "B"

temps_data$plot_num[temps_data$box_number=="box6" & between(temps_data$time, 49620, 52340)] <- 18
temps_data$location[temps_data$box_number=="box6" & between(temps_data$time, 49620, 52340)] <- "A"

temps_data$plot_num[temps_data$box_number=="box6" & between(temps_data$time, 52440, 54020)] <- 22
temps_data$location[temps_data$box_number=="box6" & between(temps_data$time, 52440, 54020)] <- "A"

temps_data$plot_num[temps_data$box_number=="box6" & between(temps_data$time, 54120, 55820)] <- 26
temps_data$location[temps_data$box_number=="box6" & between(temps_data$time, 54120, 55820)] <- "A"

temps_data$plot_num[temps_data$box_number=="box6" & between(temps_data$time, 55920, 57920)] <- 30
temps_data$location[temps_data$box_number=="box6" & between(temps_data$time, 55920, 57920)] <- "A"

temps_data$plot_num[temps_data$box_number=="box6" & between(temps_data$time, 58020, 59900)] <- 34
temps_data$location[temps_data$box_number=="box6" & between(temps_data$time, 58020, 59900)] <- "B"

temps_data$plot_num[temps_data$box_number=="box6" & temps_data$time>=60000] <- 38
temps_data$location[temps_data$box_number=="box6" & temps_data$time>=60000] <- "C"

# Box 7 ----
filter(fire_plot_info, box_number=="box7")

temps_data$plot_num[temps_data$box_number=="box7" & between(temps_data$time, 38520, 41180)] <- 3
temps_data$location[temps_data$box_number=="box7" & between(temps_data$time, 38520, 41180)] <- "B"

temps_data$plot_num[temps_data$box_number=="box7" & between(temps_data$time, 41280, 43680)] <- 7
temps_data$location[temps_data$box_number=="box7" & between(temps_data$time, 41280, 43680)] <- "C"

temps_data$plot_num[temps_data$box_number=="box7" & between(temps_data$time, 43780, 46100)] <- 11
temps_data$location[temps_data$box_number=="box7" & between(temps_data$time, 43780, 46100)] <- "C"

temps_data$plot_num[temps_data$box_number=="box7" & between(temps_data$time, 46200, 49340)] <- 15
temps_data$location[temps_data$box_number=="box7" & between(temps_data$time, 46200, 49340)] <- "A"

temps_data$plot_num[temps_data$box_number=="box7" & between(temps_data$time, 49440, 52220)] <- 19
temps_data$location[temps_data$box_number=="box7" & between(temps_data$time, 49440, 52220)] <- "B"

temps_data$plot_num[temps_data$box_number=="box7" & between(temps_data$time, 52320, 53960)] <- 23
temps_data$location[temps_data$box_number=="box7" & between(temps_data$time, 52320, 53960)] <- "A"

temps_data$plot_num[temps_data$box_number=="box7" & between(temps_data$time, 54060, 55820)] <- 27
temps_data$location[temps_data$box_number=="box7" & between(temps_data$time, 54060, 55820)] <- "B"

temps_data$plot_num[temps_data$box_number=="box7" & between(temps_data$time, 55920, 57920)] <- 31
temps_data$location[temps_data$box_number=="box7" & between(temps_data$time, 55920, 57920)] <- "C"

temps_data$plot_num[temps_data$box_number=="box7" & between(temps_data$time, 58020, 59780)] <- 35
temps_data$location[temps_data$box_number=="box7" & between(temps_data$time, 58020, 59780)] <- "C"

temps_data$plot_num[temps_data$box_number=="box7" & temps_data$time >= 59880] <- 39
temps_data$location[temps_data$box_number=="box7" & temps_data$time>=59880] <- "A"

# Box 8 ----
filter(fire_plot_info, box_number=="box8")

temps_data$plot_num[temps_data$box_number=="box8" & between(temps_data$time, 38540, 41360)] <- 2
temps_data$location[temps_data$box_number=="box8" & between(temps_data$time, 38540, 41360)] <- "C"

temps_data$plot_num[temps_data$box_number=="box8" & between(temps_data$time, 41460, 43700)] <- 6
temps_data$location[temps_data$box_number=="box8" & between(temps_data$time, 41460, 43700)] <- "C"

temps_data$plot_num[temps_data$box_number=="box8" & between(temps_data$time, 43800, 46280)] <- 10
temps_data$location[temps_data$box_number=="box8" & between(temps_data$time, 43800, 46280)] <- "C"

temps_data$plot_num[temps_data$box_number=="box8" & between(temps_data$time, 46380, 49520)] <- 14
temps_data$location[temps_data$box_number=="box8" & between(temps_data$time, 46380, 49520)] <- "C"

temps_data$plot_num[temps_data$box_number=="box8" & between(temps_data$time, 49620, 52340)] <- 18
temps_data$location[temps_data$box_number=="box8" & between(temps_data$time, 49620, 52340)] <- "C"

temps_data$plot_num[temps_data$box_number=="box8" & between(temps_data$time, 52440, 54020)] <- 22
temps_data$location[temps_data$box_number=="box8" & between(temps_data$time, 52440, 54020)] <- "C"

temps_data$plot_num[temps_data$box_number=="box8" & between(temps_data$time, 54120, 55820)] <- 26
temps_data$location[temps_data$box_number=="box8" & between(temps_data$time, 54120, 55820)] <- "C"

temps_data$plot_num[temps_data$box_number=="box8" & between(temps_data$time, 55920, 57920)] <- 30
temps_data$location[temps_data$box_number=="box8" & between(temps_data$time, 55920, 57920)] <- "C"

temps_data$plot_num[temps_data$box_number=="box8" & between(temps_data$time, 58020, 59900)] <- 34
temps_data$location[temps_data$box_number=="box8" & between(temps_data$time, 58020, 59900)] <- "A"

temps_data$plot_num[temps_data$box_number=="box8" & temps_data$time >= 60000] <- 38
temps_data$location[temps_data$box_number=="box8" & temps_data$time >= 60000] <- "B"


# Box 9 ----
filter(fire_plot_info, box_number=="box9")

temps_data$plot_num[temps_data$box_number=="box9" & between(temps_data$time, 38400, 40940)] <- 4
temps_data$location[temps_data$box_number=="box9" & between(temps_data$time, 38400, 40940)] <- "B"

temps_data$plot_num[temps_data$box_number=="box9" & between(temps_data$time, 41040, 43400)] <- 8
temps_data$location[temps_data$box_number=="box9" & between(temps_data$time, 41040, 43400)] <- "A"

temps_data$plot_num[temps_data$box_number=="box9" & between(temps_data$time, 43500, 45980)] <- 12
temps_data$location[temps_data$box_number=="box9" & between(temps_data$time, 43500, 45980)] <- "A"

temps_data$plot_num[temps_data$box_number=="box9" & between(temps_data$time, 46080, 49160)] <- 16
temps_data$location[temps_data$box_number=="box9" & between(temps_data$time, 46080, 49160)] <- "A"

temps_data$plot_num[temps_data$box_number=="box9" & between(temps_data$time, 49260, 52220)] <- 20
temps_data$location[temps_data$box_number=="box9" & between(temps_data$time, 49260, 52220)] <- "B"

temps_data$plot_num[temps_data$box_number=="box9" & between(temps_data$time, 52320, 53840)] <- 24
temps_data$location[temps_data$box_number=="box9" & between(temps_data$time, 52320, 53840)] <- "C"

temps_data$plot_num[temps_data$box_number=="box9" & between(temps_data$time, 53940, 55760)] <- 28
temps_data$location[temps_data$box_number=="box9" & between(temps_data$time, 53940, 55760)] <- "C"

temps_data$plot_num[temps_data$box_number=="box9" & between(temps_data$time, 55860, 57800)] <- 32
temps_data$location[temps_data$box_number=="box9" & between(temps_data$time, 55860, 57800)] <- "C"

temps_data$plot_num[temps_data$box_number=="box9" & between(temps_data$time, 57900, 59720)] <- 36
temps_data$location[temps_data$box_number=="box9" & between(temps_data$time, 57900, 59720)] <- "C"

temps_data$plot_num[temps_data$box_number=="box9" & temps_data$time >= 59820] <- 40
temps_data$location[temps_data$box_number=="box9" & temps_data$time >= 59820] <- "B"


# Box 10 ----
filter(fire_plot_info, box_number=="box10")

temps_data$plot_num[temps_data$box_number=="box10" & between(temps_data$time, 38720, 41540)] <- 1
temps_data$location[temps_data$box_number=="box10" & between(temps_data$time, 38720, 41540)] <- "C"

temps_data$plot_num[temps_data$box_number=="box10" & between(temps_data$time, 41640, 43940)] <- 5
temps_data$location[temps_data$box_number=="box10" & between(temps_data$time, 41640, 43940)] <- "B"

temps_data$plot_num[temps_data$box_number=="box10" & between(temps_data$time, 44040, 46880)] <- 9
temps_data$location[temps_data$box_number=="box10" & between(temps_data$time, 44040, 46880)] <- "B"

temps_data$plot_num[temps_data$box_number=="box10" & between(temps_data$time, 46980, 49760)] <- 13
temps_data$location[temps_data$box_number=="box10" & between(temps_data$time, 46980, 49760)] <- "A"

temps_data$plot_num[temps_data$box_number=="box10" & between(temps_data$time, 49860, 52400)] <- 17
temps_data$location[temps_data$box_number=="box10" & between(temps_data$time, 49860, 52400)] <- "B"

temps_data$plot_num[temps_data$box_number=="box10" & between(temps_data$time, 52500, 54020)] <- 21
temps_data$location[temps_data$box_number=="box10" & between(temps_data$time, 52500, 54020)] <- "C"

temps_data$plot_num[temps_data$box_number=="box10" & between(temps_data$time, 54120, 55940)] <- 25
temps_data$location[temps_data$box_number=="box10" & between(temps_data$time, 54120, 55940)] <- "B"

temps_data$plot_num[temps_data$box_number=="box10" & between(temps_data$time, 56040, 58040)] <- 29
temps_data$location[temps_data$box_number=="box10" & between(temps_data$time, 56040, 58040)] <- "B"

temps_data$plot_num[temps_data$box_number=="box10" & between(temps_data$time, 58140, 59960)] <- 33
temps_data$location[temps_data$box_number=="box10" & between(temps_data$time, 58140, 59960)] <- "B"

temps_data$plot_num[temps_data$box_number=="box10" & temps_data$time >= 59960] <- 37
temps_data$location[temps_data$box_number=="box10" & temps_data$time >= 59960] <- "A"

# Box 11 ----
filter(fire_plot_info, box_number=="box11")

temps_data$plot_num[temps_data$box_number=="box11" & between(temps_data$time, 38720, 41540)] <- 1
temps_data$location[temps_data$box_number=="box11" & between(temps_data$time, 38720, 41540)] <- "B"

temps_data$plot_num[temps_data$box_number=="box11" & between(temps_data$time, 41640, 43940)] <- 5
temps_data$location[temps_data$box_number=="box11" & between(temps_data$time, 41640, 43940)] <- "C"

temps_data$plot_num[temps_data$box_number=="box11" & between(temps_data$time, 44040, 46880)] <- 9
temps_data$location[temps_data$box_number=="box11" & between(temps_data$time, 44040, 46880)] <- "C"

temps_data$plot_num[temps_data$box_number=="box11" & between(temps_data$time, 46980, 49760)] <- 13
temps_data$location[temps_data$box_number=="box11" & between(temps_data$time, 46980, 49760)] <- "C"

temps_data$plot_num[temps_data$box_number=="box11" & between(temps_data$time, 49860, 52400)] <- 17
temps_data$location[temps_data$box_number=="box11" & between(temps_data$time, 49860, 52400)] <- "C"

temps_data$plot_num[temps_data$box_number=="box11" & between(temps_data$time, 52500, 54020)] <- 21
temps_data$location[temps_data$box_number=="box11" & between(temps_data$time, 52500, 54020)] <- "A"

temps_data$plot_num[temps_data$box_number=="box11" & between(temps_data$time, 54120, 55940)] <- 25
temps_data$location[temps_data$box_number=="box11" & between(temps_data$time, 54120, 55940)] <- "C"

temps_data$plot_num[temps_data$box_number=="box11" & between(temps_data$time, 56040, 58040)] <- 29
temps_data$location[temps_data$box_number=="box11" & between(temps_data$time, 56040, 58040)] <- "C"

temps_data$plot_num[temps_data$box_number=="box11" & between(temps_data$time, 58140, 59960)] <- 33
temps_data$location[temps_data$box_number=="box11" & between(temps_data$time, 58140, 59960)] <- "C"

temps_data$plot_num[temps_data$box_number=="box11" & temps_data$time >= 60060] <- 37
temps_data$location[temps_data$box_number=="box11" & temps_data$time >= 60060] <- "B"

# Box 12 ----
filter(fire_plot_info, box_number=="box12")

temps_data$plot_num[temps_data$box_number=="box12" & between(temps_data$time, 38720, 41540)] <- 1
temps_data$location[temps_data$box_number=="box12" & between(temps_data$time, 38720, 41540)] <- "A"

temps_data$plot_num[temps_data$box_number=="box12" & between(temps_data$time, 41640, 43940)] <- 5
temps_data$location[temps_data$box_number=="box12" & between(temps_data$time, 41640, 43940)] <- "A"

temps_data$plot_num[temps_data$box_number=="box12" & between(temps_data$time, 44040, 46880)] <- 9
temps_data$location[temps_data$box_number=="box12" & between(temps_data$time, 44040, 46880)] <- "A"

temps_data$plot_num[temps_data$box_number=="box12" & between(temps_data$time, 46980, 49760)] <- 13
temps_data$location[temps_data$box_number=="box12" & between(temps_data$time, 46980, 49760)] <- "B"

temps_data$plot_num[temps_data$box_number=="box12" & between(temps_data$time, 49860, 52400)] <- 17
temps_data$location[temps_data$box_number=="box12" & between(temps_data$time, 49860, 52400)] <- "A"

temps_data$plot_num[temps_data$box_number=="box12" & between(temps_data$time, 52500, 54020)] <- 21
temps_data$location[temps_data$box_number=="box12" & between(temps_data$time, 52500, 54020)] <- "B"

temps_data$plot_num[temps_data$box_number=="box12" & between(temps_data$time, 54120, 55940)] <- 25
temps_data$location[temps_data$box_number=="box12" & between(temps_data$time, 54120, 55940)] <- "A"

temps_data$plot_num[temps_data$box_number=="box12" & between(temps_data$time, 56040, 58040)] <- 29
temps_data$location[temps_data$box_number=="box12" & between(temps_data$time, 56040, 58040)] <- "A"

temps_data$plot_num[temps_data$box_number=="box12" & between(temps_data$time, 58140, 59960)] <- 33
temps_data$location[temps_data$box_number=="box12" & between(temps_data$time, 58140, 59960)] <- "A"

temps_data$plot_num[temps_data$box_number=="box12" & temps_data$time >= 60060] <- 37
temps_data$location[temps_data$box_number=="box12" & temps_data$time >= 60060] <- "C"


# Session info ----
str(temps_data)
temps_data_noNA <- filter(temps_data, !is.na(plot_num))
summary(temps_data_noNA)

ggplot(filter(temps_data_noNA, box_number=="box1"), 
       aes(time, probe_tempC, color = probe_ht)) +
  geom_path(aes()) +
  theme_classic()

write_csv(temps_data_noNA, "data/temperatureID_data_noNA.csv")

sessionInfo()




# d1 <- filter(fire_plot_info, box_number=="box1")
# d2 <- filter(temps_data, box_number=="box1")
# 
# iteration = 1
# for (n in d1$box_number) {
#   for (m in d2$box_number) {
#     if (m==n & d2$time <= d1$time_numeric + 600) {
#       d2$plot_num = d1$plot_num
#       d2$location = d1$location
#     }
#   }
#   print(iteration+1)
# }

