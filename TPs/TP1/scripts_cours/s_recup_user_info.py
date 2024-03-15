#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Importer les modules nécessaires
import os
import datetime

# Définition du chemin du répertoire où enregistrer les informations
dir_path = os.path.join(os.getcwd(), "resultats_scripts_CM")
os.makedirs(dir_path, exist_ok=True)

# Définition du chemin du fichier où enregistrer les informations
fichier_path = os.path.join(os.getcwd(), "resultats_scripts_CM", f"utilisateur_info_{datetime.datetime.now().strftime('%Y%m%d_%H%M%S')}.txt")

# Récupération du nom de l'utilisateur actuel
nom_utilisateur = os.getlogin()

# Récupération de l'ID de l'utilisateur
id_utilisateur = os.getuid()

# Récupération des groupes auxquels appartient l'utilisateur
groupes = os.getgroups()

# Affichage des informations
print(f"Utilisateur : {nom_utilisateur}")
print(f"ID Utilisateur : {id_utilisateur}")
print(f"Groupes : {groupes}")

# Enregistrement des informations dans un nouveau fichier
with open(fichier_path, "w") as fichier:
    fichier.write(f"Utilisateur : {nom_utilisateur}\n")
    fichier.write(f"ID Utilisateur : {id_utilisateur}\n")
    fichier.write(f"Groupes : {groupes}\n")

print(f"Informations enregistrées dans : {fichier_path}")

exit(0)