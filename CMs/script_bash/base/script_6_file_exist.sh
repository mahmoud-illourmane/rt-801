#!/bin/bash

# Affiche l'usage du script si aucun argument n'est fourni
if [ $# -eq 0 ]; then
    echo "Usage: $0 <nom_du_fichier>"
    exit 1
fi

# Définit le nom du fichier à partir du premier argument
file="$1"

# Tente d'obtenir le chemin absolu du répertoire contenant le script
# et vérifie si l'opération réussit
script_dir=$(dirname "$(readlink -f "$0")") || { echo "Erreur lors de la résolution du chemin du script"; exit 1; }

# Construit le chemin complet vers le fichier ciblé
file_path="${script_dir}/${file}"

# Vérifie l'existence du fichier et affiche un message approprié
if [ -e "$file_path" ]; then
    echo "Le fichier ${file} existe dans le même répertoire que le script."
else
    echo "Le fichier ${file} n'existe pas dans le même répertoire que le script."
fi
#!/bin/bash

# Vérifie si au moins un argument est fourni
if [ $# -eq 0 ]; then
    echo "Je dois utiliser ce script comme suit: $0 <nom_du_fichier>"
    exit 1
fi

# Assigne le nom du fichier fourni à une variable
fichier="$1"

# Vérifie si le fichier existe et est un fichier régulier
if [ -f "$fichier" ]; then
    echo "Le fichier '$fichier' existe et c'est un fichier régulier."
else
    if [ -e "$fichier" ]; then
        echo "Le fichier '$fichier' existe mais ce n'est pas un fichier régulier."
    else
        echo "Le fichier '$fichier' n'existe pas."
    fi
fi
