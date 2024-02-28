#!/bin/bash
# Je stocke la commande `date` dans la variable date_now
date_now=$(date)

# Je crée un fichier nommé 'date_info.txt'
# Je vais écrire la date et l'heure actuelles dedans
echo "La date et l'heure actuelles sont : $date_now" > date_info.txt

# Ensuite, je vais lister le contenu du répertoire courant et ajouter cette liste au même fichier
echo "Liste des fichiers et dossiers:" >> date_info.txt
ls >> date_info.txt