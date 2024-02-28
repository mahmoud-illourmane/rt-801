# -*- coding: utf-8 -*-
#!/usr/bin/env python
import os

# Déclarations de variables
var_bjr1 = "bonjour les amis"

# Affiche les variables et d'autres informations
print(var_bjr1)
print("L'utilisateur connecté est :", os.environ['USER'])
print("Répertoire d'exécution est :", os.getcwd())
print("Répertoire de l'utilisateur est :", os.path.expanduser('~'))
