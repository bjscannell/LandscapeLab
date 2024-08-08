## Read in Data
library(dplyr)
library(readr)

source("https://raw.githubusercontent.com/bjscannell/lab_code/master/load_vps_csvs.R")

tags <- read_csv("Acoustic_tags_PetersonLab.csv", 
                 col_types = cols(UTC_RELEASE_DATE_TIME = col_datetime(format = "%Y-%m-%d %H:%M:%S"))) %>% 
  mutate(FullId = paste(TAG_CODE_SPACE, "-", TAG_ID_CODE, sep = ""))

raw_dets <- load_vps_files()

dets <- raw_dets %>% filter(HPEs <= 10) %>%
  left_join(tags, by = "FullId")


write_csv(dets, "filtered_detections.csv")
