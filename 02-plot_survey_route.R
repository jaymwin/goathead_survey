
library(sf)
library(tmap)
library(fs)

# load survey route; this was created from mapmyrun kml file
survey_route = st_read(here::here("data"), "field_camas_canal")

# load goathead locations from epicollect
csv_files <- dir_ls(here::here('output_data'), regexp = "\\.csv$")

goatheads <- csv_files %>% 
  map_dfr(read_csv) %>%
  group_by(date) %>%
  arrange(date) %>%
  mutate(
    survey_num = as.integer(factor(date))
  ) %>%
  select(survey_num, Date = date, flowering, lat, long) %>%
  
  # turn into sf object for mapping
  st_as_sf(
    .,
    coords = c('long', 'lat'),
    crs = 4326
  )
goatheads

# plot with tmap
route_plot <- tm_shape(survey_route) +
  tm_lines(col = 'orange', lwd = 2) 

# add goathead locations
route_plot + tm_shape(goatheads) +
  tm_bubbles(col = 'Date', size = 1) +
  tm_layout('Weekly goathead survey')

# get interactive view
tmap_mode("view")
weekly_map <- tmap_last()
weekly_map

tmap_save(weekly_map, str_c(Sys.Date(), "_weekly_map.html"))
tmap_save(weekly_map, str_c(Sys.Date(), "_weekly_map.png"), width = 5, height = 4, units = 'in')
