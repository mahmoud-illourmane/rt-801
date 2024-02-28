#!/bin/bash

verifierFichier() {
  if [[ -e $1 ]]; then
    echo "Le fichier $1 existe."
  else
    echo "Le fichier $1 n'existe pas."
  fi
}

echo "Entrez le nom du fichier à vérifier :"
read nomFichier

verifierFichier $nomFichier
