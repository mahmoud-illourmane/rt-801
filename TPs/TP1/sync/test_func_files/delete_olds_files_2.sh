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

deletes_old_files() {
    local file_resources=$1
    if [ ! -e "$file_resources" ]; then
        echo_ $C_R "Erreur : Le fichier '$file_resources' n'existe pas."
        exit 1
    fi

    # Initialisation de la liste des fichiers
    files=()

    # Lecture des noms de fichiers/répertoires depuis le fichier
    while IFS= read -r file_name; do
        # Ajout du nom du fichier à la liste
        files+=("$file_name")
    done < "$file_list"

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


}
