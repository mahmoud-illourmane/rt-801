#!/bin/bash

C_G="\033[32m"
C_R="\033[31m"
C_Y="\033[33m"
C_END="\033[00m"

echo_() {
    echo -e "$1$2$C_END"
}

# Vérification du nombre de paramètres
if [ "$#" -ne 2 ]; then
    echo_ $C_R "Usage: $0 </path_ou_chercher> <ressource_a_rechercher>"
    exit 1
fi

path_to_search=$1
resource_to_search=$2

result=$(find "$path_to_search" -name "$resource_to_search")
if [ $? -ne 0 ]; then
    echo_ $C_R "Erreur lors de la recherche de la ressource."
    exit 1
fi

echo_ $C_G "$result"
