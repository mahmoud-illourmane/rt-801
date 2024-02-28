#!/bin/bash

# Vérifie si un argument est fourni
if [ $# -eq 0 ]; then
    echo "Je dois utiliser ce script comme suit: $0 <nom_du_fichier>"
    exit 1
fi

# Assigne le nom du fichier fourni à une variable
fichier="$1"

# Vérifie si le fichier existe et a une taille supérieure à zéro
if [ -s "$fichier" ]; then
    echo "Le fichier '$fichier' existe et n'est pas vide."
else
    # Vérifie si le fichier existe, même s'il est vide
    if [ -e "$fichier" ]; then
        echo "Le fichier '$fichier' existe mais est vide."
    else
        echo "Le fichier '$fichier' n'existe pas."
    fi
fi
