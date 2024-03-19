#!/bin/bash

# Vérification du nombre de paramètres
if [ "$#" -ne 4 ]; then
    echo "Usage: $0 <nom_archive> <repertoire_a_sauvegarder> <adresse_serveur_sauvegarde> <login:password>"
    exit 1
fi

# Attribution des paramètres à des variables
NOM_ARCHIVE=$1
REPERTOIRE_A_SAUVEGARDER=$2
ADRESSE_SERVEUR=$3
LOGIN_PASSWORD=$4

# Création de l'archive avec tar
tar -czf ${NOM_ARCHIVE}.tar.gz -C $(dirname "$REPERTOIRE_A_SAUVEGARDER") $(basename "$REPERTOIRE_A_SAUVEGARDER")