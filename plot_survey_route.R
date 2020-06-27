
library(sf)
library(tmap)

# load survey route
survey_route = st_read(here::here("data"), "field_camas_canal")

# plot with tmap
tm_shape(survey_route) +
  tm_lines(col = 'orange', lwd = 2)

# get interactive view
tmap_mode("view")
tmap_last()
