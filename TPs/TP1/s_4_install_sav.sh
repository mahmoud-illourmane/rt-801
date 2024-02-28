#!/bin/bash

# Pour exécuter ce script :
# Enregistre-le dans un fichier, par exemple script_installation.sh.
# Donne-lui les droits d'exécution avec la commande chmod +x script_installation.sh.
# Exécute le script avec les paramètres appropriés, par exemple : ./script_installation.sh archive.zip /chemin/vers/repertoire_base.

# Vérification du nombre de paramètres
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <nom_archive> <répertoire_base_installation>"
    exit 1
fi

NOM_ARCHIVE=$1
REPERTOIRE_BASE=$2

# Vérification de l'existence du répertoire de base
if [ ! -d "$REPERTOIRE_BASE" ]; then
    echo "Le répertoire de base d'installation n'existe pas."
    exit 1
fi

# Vérification des droits d'écriture dans le répertoire de base
if [ ! -w "$REPERTOIRE_BASE" ]; then
    echo "Permissions insuffisantes pour écrire dans le répertoire de base."
    exit 1
fi

# Détermination du type d'archive et décompression
case "$NOM_ARCHIVE" in
    *.zip)
        echo "Décompression d'un fichier zip..."
        unzip -d "$REPERTOIRE_BASE" "$NOM_ARCHIVE"
        ;;
    *.tar)
        echo "Décompression d'un fichier tar..."
        tar -xf "$NOM_ARCHIVE" -C "$REPERTOIRE_BASE"
        ;;
    *.tgz|*.tar.gz)
        echo "Décompression d'un fichier tgz..."
        tar -xzf "$NOM_ARCHIVE" -C "$REPERTOIRE_BASE"
        ;;
    *)
        echo "Type d'archive non supporté."
        exit 1
        ;;
esac

echo "Installation terminée."
