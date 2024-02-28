#!/bin/bash

# Vérifie si un argument est fourni
if [ $# -eq 0 ]; then
    echo "Je dois utiliser ce script comme suit: $0 <nom_du_fichier>"
    exit 1
    fi
                                        
    # Assigne le nom du fichier fourni à une variable
    fichier="$1"
                                        
    # Vérifie si le fichier est lisible
    if [ -r "$fichier" ]; then
        echo "Je peux lire le fichier '$fichier'."
    else
        echo "Je ne peux pas lire le fichier '$fichier'."
    fi
                                        
    # Vérifie si le fichier est modifiable
    if [ -w "$fichier" ]; then
        echo "Je peux modifier le fichier '$fichier'."
    else
        echo "Je ne peux pas modifier le fichier '$fichier'."
    fi
                                    
    # Vérifie si le fichier est exécutable
    if [ -x "$fichier" ]; then
        echo "Je peux exécuter le fichier '$fichier'."
    else
        echo "Je ne peux pas exécuter le fichier '$fichier'."
    fi  