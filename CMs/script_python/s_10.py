#!/usr/bin/env python3

with open('fichier.txt', 'w') as fichier:
    octets = fichier.write("Ceci est une ligne dans un fichier.\n")
    print(f"{octets} octets écris.")
    
with open('fichier2.txt', 'w') as fichier:
    lignes = ["Première ligne\n", "Deuxième ligne\n", "Troisième ligne\n"]
    fichier.writelines(lignes)

with open('fichier.txt', 'a') as fichier:
    octets =fichier.write("Ceci est une nouvelle ligne ajoutée au fichier.\n")
    print(f"{octets} octets écris.")