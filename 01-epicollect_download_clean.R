
library(tidyverse)
library(janitor)
library(lubridate)

epi_url <- 'https://five.epicollect.net/api/internal/download-entries/goathead-survey?filter_by=created_at&format=csv&map_index=0'
location <- str_c(here::here('data'), '/goathead_', Sys.Date(), '.zip')

# download epicollect data in zip format
download.file(epi_url, location)

# extract csv
unzip(location, exdir = here::here('data'))

# get rid of zip file
unlink(location)


# clean data --------------------------------------------------------------

dat <- read_csv(here::here('data/form-1__goathead.csv')) %>%
  clean_names() %>%
  select(
    date = x1_date, 
    flowering = x2_flowering,
    lat = lat_3_plot_center, 
    long = long_3_plot_center
    ) %>%
  mutate(date = dmy(date))
dat

dat %>%
  write_csv(str_c(here::here('output_data/'), Sys.Date(), '.csv'))
