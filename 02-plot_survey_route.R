
library(sf)
library(tmap)

# load survey route
survey_route = st_read(here::here("data"), "field_camas_canal")


# load goathead locations
goatheads <- read_csv(here::here("output_data/2020-06-26.csv")) %>%
  st_as_sf(
    .,
    coords = c('long', 'lat'),
    crs = 4326
  )
goatheads

# plot with tmap
route_plot <- tm_shape(survey_route) +
  tm_lines(col = 'orange', lwd = 2) 

route_plot + tm_shape(goatheads) +
  tm_dots(col = 'orchid', size = 0.05)

# get interactive view
tmap_mode("view")
tmap_last()
