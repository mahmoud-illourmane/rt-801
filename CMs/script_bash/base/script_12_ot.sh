#!/bin/bash

# Vérifie si deux arguments sont fournis
if [ $# -ne 2 ]; then
    echo "Je dois utiliser ce script comme suit: $0 <fichier1> <fichier2>"
    exit 1
fi

# Assigne les noms de fichiers fournis aux variables
fichier1="$1"
fichier2="$2"

# Vérifie si fichier1 est plus ancien que fichier2
if [ "$fichier1" -ot "$fichier2" ]; then
    echo "Le fichier '$fichier1' est plus ancien que '$fichier2'."
elif [ "$fichier2" -ot "$fichier1" ]; then
    echo "Le fichier '$fichier2' est plus ancien que '$fichier1'."
else
    echo "Les fichiers '$fichier1' et '$fichier2' ont la même date de modification ou l'un d'eux n'existe pas."
fi