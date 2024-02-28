#!/bin/bash

compteur=0
until [ -e fichier_2.txt ]; do
  echo "Tentative $compteur: fichier.txt non trouvé."
  sleep 1
  compteur=$((compteur+1))
  touch fichier.txt # Pour cet exemple, je crée le fichier après quelques tentatives.
  if [ $compteur -eq 5 ]; then
    echo "Fichier créé pour terminer la boucle."
    break
  fi
done
