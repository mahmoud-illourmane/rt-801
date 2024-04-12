#!/bin/bash

# Ce script exécute les opérations suivantes :

# Vérifie que le nombre correct de paramètres a été fourni.
# Crée une archive du répertoire spécifié en utilisant tar.
# Utilise sshpass et sftp pour transférer l'archive créée vers le serveur de sauvegarde spécifié.
# Il faut installer le client sftp : sudo apt-get install sshpass

# ./script_sauvegarde.sh mon_archive /chemin/vers/repertoire adresse_serveur login:password
# Remplace mon_archive, /chemin/vers/repertoire, adresse_serveur, login, et password par les valeurs appropriées pour ta sauvegarde.

# Vérification du nombre de paramètres
if [ "$#" -ne 5 ]; then
    echo -e "\e[31mUsage: $0 <nom_archive> <repertoire_a_sauvegarder> \"adresse_serveur_sauvegarde\" \"login\" \"password\" \e[0m"
    exit 1
fi

# Attribution des paramètres à des variables
NOM_ARCHIVE=$1
REPERTOIRE_A_SAUVEGARDER=$2
ADRESSE_SERVEUR=$3
LOGIN=$4
PASSWORD=$5

# Création de l'archive avec tar
if ! tar -czf "${NOM_ARCHIVE}.tar.gz" -C "$(dirname "$REPERTOIRE_A_SAUVEGARDER")" "$(basename "$REPERTOIRE_A_SAUVEGARDER")"; then
  echo -e "\e[31mÉchec de la création de l'archive.\e[0m"
  exit 1
fi
echo -e "\e[32mL'archive a bien été créée.\e[0m"

# Copie de l'archive via SFTP
if ! sshpass -p "$PASSWORD" sftp "$LOGIN@$ADRESSE_SERVEUR" <<EOF
put "${NOM_ARCHIVE}.tar.gz" /home/$LOGIN/archives
bye
EOF
then
  echo -e "\e[31mÉchec de la copie de l'archive via SFTP.\e[0m"
  exit 1
fi

if [ -f "${NOM_ARCHIVE}.tar.gz" ]; then
  rm -f "${NOM_ARCHIVE}.tar.gz"
fi

echo -e "\e[32mSauvegarde terminée : ${NOM_ARCHIVE}.tar.gz a été copié sur $ADRESSE_SERVEUR\e[0m"
exit 0
