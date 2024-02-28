#!/usr/bin/env python3
import sys

file = sys.argv[1]     
n_ligne = int(sys.argv[2]) 
fd = open(file, 'r')    

print("Lecture de la première ligne :")

fd.seek(0)  # Retour au début du fichier
premiere_ligne = fd.readline()
print("Première ligne : ", premiere_ligne) 

print("Lecture de la Nième ligne :")
fd.seek(0)                  # Retour au début du fichier
for _ in range(n_ligne):    # On saute les N premières lignes
    fd.readline()
cinquieme_ligne = fd.readline()
print("Nième ligne:", cinquieme_ligne)
    
fd.close()              
exit(0)