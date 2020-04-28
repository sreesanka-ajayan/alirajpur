york_selected <- york %>% filter(grade == "I")

york_unselected <- york %>% filter(grade != "I")

library(leaflet)
leaflet() %>%
  addCircleMarkers(data = york, 
                   radius = 1,
                   color = "steelblue") %>%
  addCircles(data = york_selected, 
             radius = 100,
             stroke = TRUE,
             fill = NULL,
             opacity = 0.8,
             weight = 2,
             color = "coral") %>%
  addProviderTiles("CartoDB.Positron") %>%
  setView(lng = median(york$long),
          lat = median(york$lat),
          zoom = 15)

dat_dist <- york_selected %>% nearest(york_crime)
head(dat_dist)
dat_dist_bldg <- york_crime %>% nearest(york_selected)
head(dat_dist_bldg)
coverage(york_selected, york_crime)

system.time(
  # mc_20 <- max_coverage(A = dat_dist_indic,
  mc_20 <- max_coverage(existing_facility = york_selected,
                        proposed_facility = york_unselected,
                        user = york_crime,
                        n_added = 20,
                        distance_cutoff = 100)
)

library("xlsx")
write.xlsx(mc_20, "mc_20.xls", sheetName = "first_20", 
           col.names = TRUE, row.names = TRUE, append = FALSE)

write.xlsx(mc_20, "mc_20.xls", sheetName = "first_20", 
           col.names = TRUE, row.names = TRUE, append = FALSE)

library(purrr)
n_add_vec <- c(20, 40, 60, 80, 100)

system.time(
  map_mc_model <- map_df(.x = n_add_vec,
                         .f = ~max_coverage(existing_facility = york_selected,
                                            proposed_facility = york_unselected,
                                            user = york_crime,
                                            distance_cutoff = 100,
                                            n_added = .))
)
map_cov_results <- bind_rows(map_mc_model$model_coverage)

library(ggplot2)
bind_rows(map_mc_model$existing_coverage[[1]],
          map_cov_results) %>%
  ggplot(aes(x = factor(n_added),
             y = pct_cov)) + 
  geom_point() +
  geom_line(group = 1) + 
  theme_minimal()








