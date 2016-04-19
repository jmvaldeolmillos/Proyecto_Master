source("stripAccent.R")
library(xlsx)
library(XLConnect)
library(stringr)
listado <- list.files()

file <- readWorksheetFromFile(listado[1],sheet= "Sheet 1",header=TRUE)

for(j in 1:length(colnames(file))){
  file[[j]] <- stripAccent(file[[j]])
}
