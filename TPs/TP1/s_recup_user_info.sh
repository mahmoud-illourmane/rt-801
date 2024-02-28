#!/bin/bash

# Copie le script dans un fichier, par exemple recup_info_utilisateur.sh.
# Donne-lui les droits d'exécution avec la commande : chmod +x recup_info_utilisateur.sh.
# Exécute le script : ./recup_info_utilisateur.sh.

# Définition du chemin du répertoire où enregistrer les informations
# Utilisation de la date et de l'heure pour créer un nom de dossier unique
DIR_PATH="$PWD/res_script_CM_1"
mkdir -p "$DIR_PATH"

# Définition du chemin du fichier où enregistrer les informations
# Utilisation de la date et de l'heure pour créer un nom de fichier unique
FILE_PATH="$PWD/script_CM_1/utilisateur_info_$(date +%Y%m%d_%H%M%S).txt"

# Récupération du nom de l'utilisateur actuel
USER_NAME=$(whoami)

# Récupération de l'ID de l'utilisateur
USER_ID=$(id -u)

# Récupération des groupes auxquels appartient l'utilisateur
GROUPS=$(id -Gn)

# Affichage des informations
echo "Utilisateur : $USER_NAME"
echo "ID Utilisateur : $USER_ID"
echo "Groupes : $GROUPS"

# Enregistrement des informations dans un nouveau fichier
echo "Utilisateur : $USER_NAME" > "$FILE_PATH"
echo "ID Utilisateur : $USER_ID" >> "$FILE_PATH"
echo "Groupes : $GROUPS" >> "$FILE_PATH"

echo "Informations enregistrées dans : $FILE_PATH"
