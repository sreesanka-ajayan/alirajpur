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