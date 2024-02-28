#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import sys
import os     

try:
    os.mkdir(sys.argv[1])
except Exception as e:  
    print(f"Erreur création du nouveau répertoire : {e}")
    exit(1)
exit(0)
