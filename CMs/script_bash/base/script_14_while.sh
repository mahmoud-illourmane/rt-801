#!/bin/bash

compteur=0
while [ ! -e fichier.txt ]; do
  echo "En attente de la création de fichier.txt..."
  sleep 1
  compteur=$((compteur+1))
  if [ $compteur -eq 10 ]; then
    echo "Temps d'attente dépassé."
    break
  fi
done
