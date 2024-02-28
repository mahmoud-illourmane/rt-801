#!/bin/bash

oldIFS=$IFS
chaine="Bonjour;Hello;Hola"
echo $chaine
# Redifinition de l'IFS
IFS=';'
echo $chaine
IFS=$oldIFS
echo $chaine