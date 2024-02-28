#!/bin/bash

# Vérifie si un argument est fourni
if [ $# -eq 0 ]; then
    echo "Je dois utiliser ce script comme suit: $0 <nom_du_répertoire>"
    exit 1
fi

# Assigne le nom du répertoire fourni à une variable
repertoire="$1"

# Vérifie si le chemin existe et est un répertoire
if [ -d "$repertoire" ]; then
    echo "Le répertoire '$repertoire' existe."
else
    echo "Le répertoire '$repertoire' n'existe pas ou ce n'est pas un répertoire."
fi
