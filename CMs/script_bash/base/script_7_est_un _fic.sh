#!/bin/bash

# Vérifie si au moins un argument est fourni
if [ $# -eq 0 ]; then
    echo "Je dois utiliser ce script comme suit: $0 <nom_du_fichier>"
    exit 1
fi

# Assigne le nom du fichier fourni à une variable
fichier="$1"

# Vérifie si le fichier existe et est un fichier
if [ -f "$fichier" ]; then
    echo "Le fichier '$fichier' existe et c'est un fichier."
else
    if [ -e "$fichier" ]; then
        echo "Le fichier '$fichier' existe mais ce n'est pas un fichier."
    else
        echo "Le fichier '$fichier' n'existe pas."
    fi
fi
