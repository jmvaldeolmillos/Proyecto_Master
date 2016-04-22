
#!/usr/bin/env python
# -*- coding: utf-8 -*-

# carga de librerias de scrapping
import os
import requests
import urllib
from bs4 import BeautifulSoup


linkDatos = "http://www.datosabiertos.jcyl.es/web/jcyl/set/es/medio-ambiente/calidad_aire_historico/1284212629698"
linkEstaciones = "http://www.datosabiertos.jcyl.es/web/jcyl/set/es/medio-ambiente/calidad_aire_estaciones/1284212701893"

# Extraemos el link del ultimo csv de los Historicos.
if not os.path.exists("data"):
    os.makedirs("data")
r = requests.get(linkDatos)
enlace = BeautifulSoup(r.content)
for link in enlace.findAll("a"):
    if ".csv" in link.get("href"):
        urllib.urlretrieve(link.get("href"), "data/historico.csv")
        #convertimos a utf-8
        f= open("data/historico.csv", 'rb')
        content= unicode(f.read(), 'windows-1252')
        f.close()
        f= open("data/historicoOk.csv", 'wb')
        f.write(content.encode('utf-8'))
        f.close()
        break
os.system("mv data/historicoOk.csv data/historico.csv")

# Extraemos el link del ultimo csv de los Estaciones.
r = requests.get(linkEstaciones)
enlace = BeautifulSoup(r.content)
for link in enlace.findAll("a"):
    if ".csv" in link.get("href"):
        urllib.urlretrieve(link.get("href"), "data/estaciones.csv")
        #convertimos a utf-8
        f= open("data/estaciones.csv", 'rb')
        content= unicode(f.read(), 'windows-1252')
        f.close()
        f= open("data/estacionesOk.csv", 'wb')
        f.write(content.encode('utf-8'))
        f.close()
        break
os.system("mv data/estacionesOk.csv data/estaciones.csv")

