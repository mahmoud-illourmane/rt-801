# -*- coding: utf-8 -*-
#!/usr/bin/env python3

import re

# Compilation de l'expression régulière
pattern = re.compile(r'\d+')  # Trouver des séquences de chiffres

# Utilisation de l'objet de motif 
# compilé pour rechercher dans une chaîne
match = pattern.search('Le numéro est 12345')
if match:
    print(match.group())

