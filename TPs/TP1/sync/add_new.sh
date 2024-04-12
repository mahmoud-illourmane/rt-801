#!/bin/bash

C_G="\033[32m"
C_R="\033[31m"
C_Y="\033[33m"
C_END="\033[00m"

echo_() {
    echo -e "$1$2$C_END"
}

# Vérification du nombre de paramètres
if [ "$#" -ne 1 ]; then
    echo_ $C_R "Usage: $0 <fichier>"
    exit 1
fi

fichier=$1

echo_ $_Y "Entrez le répertoire ou fichier à ajouter à la liste :"
read new_value
echo "$new_value" >> $fichier
if [ $? -ne 0 ]; then
    echo_ $C_R "Erreur lors de l'ajout de la nouvelle ressource."
    exit 1
fi