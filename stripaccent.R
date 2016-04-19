library(stringr)
stripAccent <- function(string){
  
  string <- str_replace_all(string,"[áàäâ]","a")
  string <- str_replace_all(string,"[éèëê]","e")
  string <- str_replace_all(string,"[íìïî]","i")
  string <- str_replace_all(string,"[óòöô]","o")
  string <- str_replace_all(string,"[úùüû]","u")
  string <- str_replace_all(string,"[ÁÀÄÂ]","A")
  string <- str_replace_all(string,"[ÉÈËÊ]","E")
  string <- str_replace_all(string,"[ÍÌÏÎ]","I")
  string <- str_replace_all(string,"[ÓÒÖÔ]","O")
  string <- str_replace_all(string,"[ÚÙÜÛ]","U")
  string <- str_replace_all(string,"Ñ","N") 
  string <- str_replace_all(string,"ñ","n")
  return(string)
}
