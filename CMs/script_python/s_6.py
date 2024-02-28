#!/usr/bin/env python3
import sys

# Vérification de l'argument
if len(sys.argv) <= 1:
    sys.stderr.write("Vous devez indiquer un nom de fichier en argument.\n")
    exit(1)

file = sys.argv[1]      # Récupération du nom du fichier
fd = open(file, 'r')    # Ouverture du fichier en mode lecture
content = fd.read()     # Lecture du fichier
print(content)          # Affichage du contenu du fichier

fd.close()              # Fermeture du fichier
exit(0)
