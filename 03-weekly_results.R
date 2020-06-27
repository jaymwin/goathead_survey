
library(tidyverse)
library(fs)

# find weekly csv files from epicollect
csv_files <- dir_ls(here::here('output_data'), regexp = "\\.csv$")

# read, combine, add survey number, and number of flowering goatheads per survey
weekly_counts <- csv_files %>% 
  map_dfr(read_csv) %>%
  group_by(date) %>%
  arrange(date) %>%
  mutate(
    survey_num = as.integer(factor(date))
    ) %>%
  select(survey_num, date, flowering, lat, long)
weekly_counts

# summarize total count for each week
weekly_total <- weekly_counts %>%
  group_by(survey_num, date) %>%
  tally()
weekly_total
