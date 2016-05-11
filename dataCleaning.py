#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Carga librerias
import numpy as np
import os
import pandas as pd
# Se debe cambiar el directory cuando se pase al servidor!!!!
directory = os.getcwd()

# Carga fichero estaciones
estaciones = pd.read_csv(directory + '/data/estaciones.csv', sep=";")

# Renombrado columnas
estaciones.columns = ['estacion', 'localizacion', 'provincia','longitud','latitud','altura','operativa']

# Limpieza de datos
estaciones.localizacion = estaciones.localizacion.str.replace('C/', 'Calle')
estaciones.altura = estaciones.altura.str.replace('m', '')
estaciones.altura = estaciones.altura.str.rstrip()

estaciones.longitud = estaciones.longitud.str.replace('W',' W')
estaciones.longitud = estaciones.longitud.str.replace('  ',' ')
estaciones.longitud = estaciones.longitud.str.replace('º',' ')
estaciones.longitud = estaciones.longitud.str.replace("'",' ')
estaciones.longitud = estaciones.longitud.str.replace('"',' ')
estaciones.longitud = estaciones.longitud.str.replace("’",' ')
estaciones.longitud = estaciones.longitud.str.replace("”",' ')
estaciones.longitud = estaciones.longitud.str.replace("´",' ')

estaciones.latitud = estaciones.latitud.str.replace('N',' N')
estaciones.latitud = estaciones.latitud.str.replace('  ',' ')
estaciones.latitud = estaciones.latitud.str.replace('º',' ')
estaciones.latitud = estaciones.latitud.str.replace("'",' ')
estaciones.latitud = estaciones.latitud.str.replace('"',' ')
estaciones.latitud = estaciones.latitud.str.replace("’",' ')
estaciones.latitud = estaciones.latitud.str.replace("”",' ')
estaciones.latitud = estaciones.latitud.str.replace("´",' ')

# Remplazando acentos
for col in estaciones.columns:
    estaciones[col] = estaciones[col].str.replace('Á', 'A')
    estaciones[col] = estaciones[col].str.replace('É', 'E')
    estaciones[col] = estaciones[col].str.replace('Í', 'I')
    estaciones[col] = estaciones[col].str.replace('Ó', 'O')
    estaciones[col] = estaciones[col].str.replace('Ú', 'U')
    estaciones[col] = estaciones[col].str.replace('á', 'a')
    estaciones[col] = estaciones[col].str.replace('é', 'e')
    estaciones[col] = estaciones[col].str.replace('í', 'i')
    estaciones[col] = estaciones[col].str.replace('ó', 'o')
    estaciones[col] = estaciones[col].str.replace('ú', 'u')
    estaciones[col] = estaciones[col].str.replace('ñ', 'n')
    estaciones[col] = estaciones[col].str.replace('Ñ', 'N')
    estaciones[col] = estaciones[col].str.replace('II', '2')

# Paso a minusculas
for col in estaciones.columns:
    if col != "provincia":
        estaciones[col] = estaciones[col].str.title()

# Paso de grados, minutos y segundos a decimal para Geolocalizacion

def pasoDMS2DD(cadena):
    value = [int(s) for s in cadena.split() if s.isdigit()]
    dd = float(value[0]) + float(value[1])/60 + float(value[2])/(60*60)
    direction = cadena[-1]
    if (direction == 'S') or (direction == 'W'):
        dd *= -1
    return dd

# aplicamos a longitud
estaciones.longitud = estaciones.longitud.map(pasoDMS2DD)

# aplicamos a latitud
estaciones.latitud = estaciones.latitud.map(pasoDMS2DD)

# Guardar en fichero estaciones.
estaciones.to_csv('data/estacionesok.csv', sep=";", index=None, encoding="utf-8")

# Carga fichero historico
historico = pd.read_csv('data/historico.csv',sep=";",low_memory=False)

# Renombrado columnas
historico.columns = ['date','co','no','no2','ozone','pm10','sh2','pm25','pst','so2','provincia','estacion']

# Limpieza de datos
for col in ['provincia', 'estacion']:
    historico[col] = historico[col].str.replace('Á', 'A')
    historico[col] = historico[col].str.replace('É', 'E')
    historico[col] = historico[col].str.replace('Í', 'I')
    historico[col] = historico[col].str.replace('Ó', 'O')
    historico[col] = historico[col].str.replace('Ú', 'U')
    historico[col] = historico[col].str.replace('á', 'a')
    historico[col] = historico[col].str.replace('é', 'e')
    historico[col] = historico[col].str.replace('í', 'i')
    historico[col] = historico[col].str.replace('ó', 'o')
    historico[col] = historico[col].str.replace('ú', 'u')

# Guardar en fichero historico
historico.to_csv('data/historicook.csv', sep=";", index=None, encoding="utf-8")