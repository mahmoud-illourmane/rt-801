#!/usr/bin/env python3
import filecmp
import pprint
import os
import sys

def comparer_repertoires(repertoire1, repertoire2):
    # Je construis le chemin complet vers les répertoires 
    # en supposant qu'ils sont dans le répertoire courant
    chemin_complet_rep1 = os.path.join(os.getcwd(), repertoire1)
    chemin_complet_rep2 = os.path.join(os.getcwd(), repertoire2)

    # Je crée un objet dircmp pour comparer les deux répertoires
    comparaison = filecmp.dircmp(chemin_complet_rep1, chemin_complet_rep2)

    # J'affiche les fichiers et répertoires uniquement présents dans chaque répertoire
    print(f"Fichiers uniquement dans {repertoire1}:")
    pprint.pprint(comparaison.left_only)
    print(f"Fichiers uniquement dans {repertoire2}:")
    pprint.pprint(comparaison.right_only)

    # J'affiche les fichiers communs avec des différences
    print("Fichiers communs avec des différences:")
    pprint.pprint(comparaison.diff_files)

    # Pour les sous-répertoires communs, je peux faire une comparaison récursive
    for sub_repertoire, sub_comparaison in comparaison.subdirs.items():
        print(f"\nComparaison du sous-répertoire: {sub_repertoire}")
        comparer_repertoires(os.path.join(repertoire1, sub_repertoire), os.path.join(repertoire2, sub_repertoire))

# Exemple d'utilisation avec des noms de répertoires directement dans le code
repertoire1 = sys.argv[1]
repertoire2 = sys.argv[2]
comparer_repertoires(repertoire1, repertoire2)

