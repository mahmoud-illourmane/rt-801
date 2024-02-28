#!/usr/bin/env python3
import sys
import os

rep = sys.argv[1]

if os.path.isdir(rep):
    print("C'est un répertoire.")
else:
    print("Ce n'est pas un répertoire.")

exit(0)
    