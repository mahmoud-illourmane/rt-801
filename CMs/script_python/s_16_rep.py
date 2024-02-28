#!/usr/bin/env python3
import filecmp
import sys

fichier_1 = sys.argv[1]
fichier_2 = sys.argv[2]

res = filecmp.cmp(fichier_1, fichier_2)
if res:
    print("Les fichiers sont identiques.")
else:
    print("Les fichiers ne sont pas identiques.")
exit(0)