library(maxcovr)
library(dplyr)
library(readxl)
rdata_full <- read_excel("rdata_full.xls")
View(rdata_full)

rdata_alj<-rdata_full[197,]

library(readxl)
rdata_ini <- read_excel("rdata_ini.xlsx")
View(rdata_ini)

library(leaflet)
leaflet() %>%
  addCircleMarkers(data = rdata_full, 
                   radius = 1,
                   color = "steelblue") %>%
  addCircles(data =rdata_alj , 
             radius = 5000,
             stroke = TRUE,
             fill = NULL,
             opacity = 0.8,
             weight = 2,
             color = "coral") %>%
  addProviderTiles("CartoDB.Positron") %>%
  setView(lng = median(rdata_full$long),
          lat = median(rdata_full$lat),
          zoom = 10)

dat_dist <- rdata_alj%>% nearest(rdata_full)

system.time(
  al_20 <- max_coverage(existing_facility = rdata_alj,
                        proposed_facility = rdata_full,
                        user = rdata_full,
                        n_added = 20,
                        distance_cutoff = 5000)
)

library(purrr)
n_add_vec <- c(5, 10, 15, 20, 25)

system.time(
  map_al_model <- map_df(.x = n_add_vec,
                         .f = ~max_coverage(existing_facility = rdata_alj,
                                            proposed_facility = rdata_full,
                                            user = rdata_full,
                                            distance_cutoff = 5000,
                                            n_added = .))
)
map_al_cov_results <- bind_rows(map_al_model$model_coverage)

#printing the image
jpeg(file="plot_F5km.jpeg")
library(ggplot2)
bind_rows(map_al_model$existing_coverage[[1]],
          map_al_cov_results) %>%
  ggplot(aes(x = factor(n_added),
             y = pct_cov)) + 
  geom_point() +
  geom_line(group = 1) + 
  theme_minimal()
dev.off()

library("xlsx")
write.xlsx(map_al_cov_results, "R_result_5km.xls", sheetName = "area", 
           col.names = TRUE, row.names = TRUE, append = FALSE)

#finding the selected facilityes and exporing it in to dataframe
res_20<-as.data.frame(al_20$facility_selected)

#exporting to exel
write.xlsx(res_20, "R_set_fac_20.xls", sheetName = "area", 
           col.names = TRUE, row.names = TRUE, append = FALSE)



