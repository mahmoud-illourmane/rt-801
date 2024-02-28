#!/bin/bash
filename='date_info.txt'
i=1
while read line; do
    # Affichage du numéro de ligne et du contenu de la ligne
    echo "Ligne $i: $line"
    i=$((i + 1))
done < $filename
