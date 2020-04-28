library(devtools)
install_github("njtierney/maxcovr")
library("maxcovr", lib.loc="~/R/win-library/3.6")
library("xlsx")
write.xlsx(york, "york.xls", sheetName = "york", 
           col.names = TRUE, row.names = TRUE, append = FALSE)
write.xlsx(york_crime, "york_crime.xls", sheetName = "york_crime", 
           col.names = TRUE, row.names = TRUE, append = FALSE)
library(dplyr)

york_selected <- york %>% filter(grade == "I")
write.xlsx(york_selected, "york_selected.xls", sheetName = "york_selected", 
           col.names = TRUE, row.names = TRUE, append = FALSE)

york_unselected <- york %>% filter(grade != "I")
write.xlsx(york_unselected, "york_unselected.xls", sheetName = "york_unselected", 
           col.names = TRUE, row.names = TRUE, append = FALSE)

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