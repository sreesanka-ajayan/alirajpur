#enter the data set
library(readxl)
vilage_N_copy_ <- read_excel("vilage_N(copy).xls")
View(vilage_N_copy_)

#check the data 
vilage_N_copy_

#check the class
class(vilage_N_copy_)

#if it is charactor use this coment to chance to numeric
pop_lost<-as.numeric(vilage_N_copy_$populatation)

#percentage function change .16 as u r persentage
Percent_out<-function(vect){
  new_output<- vect*.16
  new_output
  
}

#calling and storing the data
populatation_girl<-sapply(pop_lost,Percent_out)


up_sheet<- cbind(vilage_N_copy_,populatation_girl)
install.packages("xlsx")
library("xlsx")
write.xlsx(up_sheet, "vilage_GT1.xls", sheetName = "girl_per", 
           col.names = TRUE, row.names = TRUE, append = FALSE)

library(readxl)
village_pop <- read_excel("vilage_GT1.xls")
View(village_lef )


