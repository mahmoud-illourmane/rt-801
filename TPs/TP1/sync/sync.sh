#!/bin/bash

#
#   Ce script est utilisé synchroniser
#   Les fichiers et répertoires entre trois VM
#  

C_G="\033[32m"
C_R="\033[31m"
C_Y="\033[33m"
C_END="\033[00m"

echo_() {
    echo -e "$1$2$C_END"
}

# Vérification du nombre de paramètres
if [ "$#" -ne 6 ]; then
    echo_ $C_R "Usage: $0 <vm_1_login> <pass_vm_1> <ip_vm_1> <vm_2_login> <pass_vm_2> <ip_vm_2>"
    exit 1
fi

vm_1_login=$1
pass_vm_1=$2
ip_vm_1=$3

vm_2_login=$4
pass_vm_2=$5
ip_vm_2=$6

echo_ $C_G "$pass_vm_1"

echo_ $C_Y "Connexion à la première VM pour récuperer la liste des fichiers..."
# Première connexion VM1
if ! sshpass -p "$pass_vm_1" sftp "$vm_1_login@$ip_vm_1" <<EOF
cd /home/$vm_1_login/sync/scripts
get "resources_"$vm_1_login".txt"
bye
EOF
then
  echo_ $C_R "Échec de la récupération de la liste des fichiers sur la VM : $vm_1_login"
  exit 1
fi
echo_ $C_G "Liste des fichiers récupérés depuis la VM : $vm_1_login"
sleep 2

echo_ $C_Y "Connexion à la deuxième VM pour récuperer la liste des fichiers..."
# Première connexion VM1
if ! sshpass -p "$pass_vm_2" sftp "$vm_2_login@$ip_vm_2" <<EOF
cd /home/$vm_2_login/sync/scripts
get "resources_"$vm_2_login".txt"
bye
EOF
then
  echo_ $C_R "Échec de la récupération de la liste des fichiers sur la VM : $vm_2_login"
  exit 1
fi
echo_ $C_G "Liste des fichiers récupérés depuis la VM : $vm_2_login"
sleep 2

exit 0
