#!/bin/bash

# Usage: ./start_container.sh <container_name_or_pattern>

# Vérifie si un argument est passé au script
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <container_name_or_pattern>"
    exit 1
fi

INPUT=$1

# Fonction pour démarrer un conteneur
start_container() {
    lxc-start -n "$1" -d
    if [ $? -eq 0 ]; then
        echo "Conteneur $1 démarré."
    else
        echo "Erreur lors du démarrage du conteneur $1."
    fi
}

# Si l'argument contient '*', traiter comme un motif
if [[ "$INPUT" == *\** ]]; then
    # Convertit le motif en expression régulière pour grep
    REGEX="${INPUT//\*/.*}"
    # Liste tous les conteneurs et filtre ceux qui correspondent au motif
    for CONTAINER in $(lxc-ls | grep -E "$REGEX"); do
        start_container "$CONTAINER"
    done
else
    # Traite l'argument comme un nom de conteneur spécifique
    start_container "$INPUT"
fi

exit 0