library("rvest")
DIR_BASE <- "/home/jose/Repos/Proyecto_Master/"

historicos <- "http://www.datosabiertos.jcyl.es/web/jcyl/set/es/medio-ambiente/calidad_aire_historico/1284212629698/"
estaciones <- "http://www.datosabiertos.jcyl.es/web/jcyl/set/es/medio-ambiente/calidad_aire_estaciones/1284212701893/"

# cargamos las páginas
web_historicos <- read_html(calidad)
web_estaciones <- read_html(estaciones)

# buscamos el enlace del csv.
urls <- web_historicos %>% 
    html_nodes("a") %>%
    html_attr("href")
data_historico <- urls[grepl(".csv", urls)]
urls <- web_estaciones %>% 
    html_nodes("a") %>%
    html_attr("href")
data_estacion <- urls[grepl(".csv", urls)]

# leemos los csv.
historico <- read.csv(data_historico, header=TRUE, sep=";", dec=".")
estacion <- read.csv(data_estacion, header=TRUE, sep=";", dec=".")

# Escrbimos los csv.
write.csv(historico, paste(DIR_BASE, "data/historico.csv"))
write.csv(estaciones, paste(DIR_BASE, "data/estacion.csv"))