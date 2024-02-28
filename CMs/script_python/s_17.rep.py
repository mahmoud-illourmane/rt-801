#!/usr/bin/env python3
import sys
import os

fichier = sys.argv[1]

if os.path.isfile(fichier):
    print("C'est un fichier.")
else:
    print("Ce n'est pas un fichier.")

exit(0)
    