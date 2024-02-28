#!/bin/bash

# Définition de la fonction d'affichage
afficher_infos() {
    local IFS_SAVE=$IFS  # Sauvegarde de l'IFS actuel
    IFS=';'              # Définition de la virgule comme nouveau IFS
    for var in $1 
    do
        echo $var
    done
    IFS=$IFS_SAVE
    echo "======="
}

# Lecture du fichier ligne par ligne
while read LINE 
do
    afficher_infos $LINE
done < "fic.txt"
