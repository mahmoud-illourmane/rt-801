#!/bin/bash

# Définition des codes de couleur
C_G="\033[32m"
C_R="\033[31m"
C_Y="\033[33m"
C_END="\033[00m"

# Fonction pour afficher les messages avec la couleur appropriée
echo_() {
    echo -e "$1$2$C_END"
}

# Demande à l'utilisateur combien de fichiers entrer
echo_ $C_Y "Combien de fichiers voulez-vous entrer ?"
read num_files
if ! [[ "$num_files" =~ ^[0-9]+$ ]]; then
    echo_ $C_R "Erreur : Vous avez entré une valeur qui n'est pas un entier."
    exit 1
fi

# Initialisation de la liste des fichiers
files=()

# Lecture des noms de fichiers que l'utilisateur souhaite entrer
for (( i = 1; i <= num_files; i++ )); do
    echo "Entrez le nom du fichier $i :"
    read file_name
    # Ajout du nom du fichier à la liste
    files+=("$file_name")
done

# Vérification que les fichiers entrés existent
for file in "${files[@]}"; do
    if [ ! -e "$file" ]; then
        echo_ $C_R "Erreur : Le fichier '$file' n'existe pas."
        exit 1
    fi
done

# Trier les fichiers par ordres de modifications
ls -t "${files[@]}" > tmp_file_list.txt
if [ $? -ne 0 ]; then
    echo_ $C_R "Erreur lors de l'exécution de la commande ls -t."
    exit 1
fi

# Vérification que le fichier tmp_file_list.txt n'est pas vide
if [ ! -s tmp_file_list.txt ]; then
    echo_ $C_R "Erreur : tmp_file_list.txt est vide ou inexistant."
    exit 1
fi

# Lecture du fichier le plus récent
read most_recent_file < tmp_file_list.txt

# Suppression des autres fichiers sauf le plus récent
for file in "${files[@]}"; do
    if [ "$file" != "$most_recent_file" ]; then
        rm "$file"
        if [ $? -ne 0 ]; then
            echo_ $C_R "Erreur : Impossible de supprimer le fichier '$file'."
        else
            echo_ $C_Y "Fichier '$file' supprimé avec succès."
        fi
    fi
done

# Suppression du fichier temporaire
rm tmp_file_list.txt
if [ $? -ne 0 ]; then
    echo_ $C_R "Erreur lors de la suppression du fichier tmp."
    exit 1
fi

# Afficher le nom du fichier le plus récent
echo_ $C_G "Le fichier le plus récent est : $most_recent_file"

exit 0
