#!/bin/bash

#
# Ce script permet d'ajouter
# une entrée au fichier de sauvegarde.
# Cle_vm : C2 ou C3
#

# Définir les codes de couleur ANSI
C_G="\033[32m"      # Vert
C_R="\033[31m"      # Rouge
C_Y="\033[33m"      # Jaune
C_END="\033[00m"    # Fin de couleur

# Fonction pour afficher des messages avec une couleur spécifique
echo_() {
    echo -e "$1$2$C_END"
}

# Vérification du nombre de paramètres
if [ "$#" -ne 2 ]; then
    echo_ $C_R "Usage: $0 <fichier> <cle_vm>"
    exit 1
fi

if [ "$2" != "c2" ] && [ "$2" != "C2" ] && [ "$2" != "c3" ] && [ "$2" != "C3" ]; then
    echo_ $C_R "$2 doit être C2 ou C3"
    exit 1
fi

# Définir le fichier à utiliser en ajoutant les paramètres
fichier="${1}_${2}.txt"

echo_ $C_Y "Entrez le répertoire ou un fichier à ajouter à la liste :"
read new_value

# Vérifier que l'entrée utilisateur n'est pas vide
if [ -z "$new_value" ]; then
    echo_ $C_R "Erreur : Aucune entrée n'a été fournie."
    exit 1
fi

# Ajouter l'entrée utilisateur au fichier
echo "$new_value" >> "$fichier"

# Vérifier le succès de l'ajout
if [ $? -ne 0 ]; then
    echo_ $C_R "Erreur lors de l'ajout de la nouvelle ressource."
    exit 1
fi

echo_ $C_G "Nouvelle source de sauvegarde ajoutée avec succès."

# Fin du script
exit 0
