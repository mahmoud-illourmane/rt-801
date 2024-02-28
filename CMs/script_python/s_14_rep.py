#!/usr/bin/env python3
import shutil
import os
import sys

source_file = sys.argv[1]       # Nom du fichier source à copier
destination_dir = 'backup/'     # Dossier de destination

# Je vérifie si le répertoire de destination existe, sinon je le crée
if not os.path.exists(destination_dir):
    os.makedirs(destination_dir)

# Chemin complet du fichier de destination
destination_file = os.path.join(destination_dir, os.path.basename(source_file))

# Je copie le fichier seulement s'il n'existe pas déjà dans le répertoire de destination
if not os.path.exists(destination_file):
    shutil.copy(source_file, destination_dir)
    print(f"Le fichier {source_file} a été copié vers {destination_dir}")
else:
    print(f"Le fichier {source_file} existe déjà dans le répertoire de destination.")
