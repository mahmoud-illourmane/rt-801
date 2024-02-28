#!/bin/bash

# Ce script exécute les opérations suivantes :

# Vérifie que le nombre correct de paramètres a été fourni.
# Crée une archive du répertoire spécifié en utilisant tar.
# Utilise sshpass et sftp pour transférer l'archive créée vers le serveur de sauvegarde spécifié.

# ./script_sauvegarde.sh mon_archive /chemin/vers/repertoire adresse_serveur login:password
# Remplace mon_archive, /chemin/vers/repertoire, adresse_serveur, login, et password par les valeurs appropriées pour ta sauvegarde.

# Vérification du nombre de paramètres
if [ "$#" -ne 4 ]; then
    echo "Usage: $0 <nom_archive> <repertoire_a_sauvegarder> <adresse_serveur_sauvegarde> <login:password>"
    exit 1
fi

# Attribution des paramètres à des variables
NOM_ARCHIVE=$1
REPERTOIRE_A_SAUVEGARDER=$2
ADRESSE_SERVEUR=$3
LOGIN_PASSWORD=$4

# Création de l'archive avec tar
tar -czf ${NOM_ARCHIVE}.tar.gz -C $(dirname "$REPERTOIRE_A_SAUVEGARDER") $(basename "$REPERTOIRE_A_SAUVEGARDER")

# Extraction du login et du mot de passe depuis le paramètre
LOGIN=$(echo $LOGIN_PASSWORD | cut -d':' -f1)
PASSWORD=$(echo $LOGIN_PASSWORD | cut -d':' -f2)

# Utilisation de sshpass et sftp pour copier l'archive sur le serveur de sauvegarde
# On s'assure que sshpass est installé, sinon on l'installe avec `sudo apt-get install sshpass`
sshpass -p "$PASSWORD" sftp -oBatchMode=no -b - $LOGIN@$ADRESSE_SERVEUR <<EOF
put ${NOM_ARCHIVE}.tar.gz
bye
EOF

echo "Sauvegarde terminée : ${NOM_ARCHIVE}.tar.gz a été copié sur $ADRESSE_SERVEUR"
