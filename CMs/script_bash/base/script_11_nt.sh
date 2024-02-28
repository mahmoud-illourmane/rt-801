#!/bin/bash

# Vérifie si deux arguments sont fournis
if [ $# -ne 2 ]; then
    echo "Je dois utiliser ce script comme suit: $0 <fichier1> <fichier2>"
    exit 1
fi

# Assigne les noms des fichiers fournis à des variables
fichier1="$1"
fichier2="$2"

# Vérifie si fichier1 est plus récent que fichier2
if [ "$fichier1" -nt "$fichier2" ]; then
    echo "Le fichier '$fichier1' est plus récent que le fichier '$fichier2'."
elif [ "$fichier2" -nt "$fichier1" ]; then
    echo "Le fichier '$fichier2' est plus récent que le fichier '$fichier1'."
else
    echo "Les fichiers '$fichier1' et '$fichier2' ont la même date de modification ou l'un d'eux n'existe pas."
fi