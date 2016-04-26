#!/bin/bash
# Setup your workspace
BASE_DIR=/home/jose/Proyecto_Master
DB_PATH=$BASE_DIR/airqualityCyL.db
DATA_DIR=$BASE_DIR/data

# First remove the existing database file, if any
rm -f $DB_PATH

# creacion de las tablas
csvsql -d';' data/estacionesok.csv --tables estacion | sqlite3 airqualityCyL.db
csvsql -d';' data/historicook.csv --tables historico | sqlite3 airqualityCyL.db 


# carga de datos en las tablas.
csvsql -d";" --db sqlite:///$DB_PATH \
    --insert --no-create --table historico $DATA_DIR/historicook.csv

csvsql -d";" --db sqlite:///$DB_PATH \
    --insert --no-create --table estacion $DATA_DIR/estacionesok.csv
