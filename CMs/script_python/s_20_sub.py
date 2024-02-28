#!/usr/bin/env python3
import subprocess

# J'exécute la commande 'ls' et je capture la sortie
result = subprocess.run(['ls', '-al'], stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)

# J'affiche la sortie de la commande
if result.returncode == 0:
    print("Sortie de la commande 'ls':\n", result.stdout)
else:
    print("Erreur lors de l'exécution de 'ls':\n", result.stderr)
