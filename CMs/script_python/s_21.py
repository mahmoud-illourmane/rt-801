#!/usr/bin/env python3
import subprocess

try:
    # Exécution de la commande 'ls -l' à travers le shell
    # Lève une exception si la commande échoue
    subprocess.run('ls -l', shell=True, check=True)
except subprocess.CalledProcessError as e:
    print(f"Erreur: La commande a échoué avec le code de retour {e.returncode}")
    exit(1)
exit(0)