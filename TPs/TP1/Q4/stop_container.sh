#!/bin/bash

# Usage: ./stop_container.sh <container_name_or_pattern>

# Vérifie si un argument est passé au script
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <container_name_or_pattern>"
    exit 1
fi

INPUT=$1

# Fonction pour arrêter un conteneur
stop_container() {
    lxc-stop -n "$1"
    if [ $? -eq 0 ]; then
        echo "Conteneur $1 arrêté."
    else
        echo "Erreur lors de l'arrêt du conteneur $1."
    fi
}

# Vérifie si l'argument est un motif
if [[ "$INPUT" == 'cnt_*' ]]; then
    # L'argument est un motif, traiter comme tel
    PATTERN="^${INPUT//\*/.*}$" # Convertit le motif en expression régulière pour grep
    # Liste tous les conteneurs et filtre ceux qui correspondent au motif
    for CONTAINER in $(lxc-ls | grep -E "$PATTERN"); do
        stop_container "$CONTAINER"
    done
else
    # Traite l'argument comme un nom de conteneur spécifique
    stop_container "$INPUT"
fi
