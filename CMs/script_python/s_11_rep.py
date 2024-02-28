#!/usr/bin/env python3

import os
import shutil
import filecmp

os.chdir("..")
fic = os.listdir("./")
for i in fic:
    print(i)
    
try:
    os.mkdir("NewRep")
except Exception:
    print(f"Erreur création du nouveau répertoire")
    exit(1)

exit(0)
