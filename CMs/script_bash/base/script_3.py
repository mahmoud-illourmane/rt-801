# -*- coding: utf-8 -*-
#!/usr/bin/env python3

import subprocess
import sys

print("Ce script se nomme :", sys.argv[0])
# Vérifie si au moins un argument a été passé
if len(sys.argv) > 1:
    print("Le premier argument passé est :", sys.argv[1])
else:
    print("Aucun argument n'a été passé.")

# Exécute le script script_1.py
try:
    result = subprocess.call(["python3", "script_1.py"], check=True)
    print("La dernière commande a réussi avec le code de sortie :", result.returncode)
except subprocess.CalledProcessError as e:
    print("La dernière commande a échoué avec le code de sortie :", e.returncode)
    exit_code = e.returncode
else:
    exit_code = 0

sys.exit(exit_code)
