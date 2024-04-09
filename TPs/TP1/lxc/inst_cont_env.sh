#!/bin/bash

C_G="\033[32m"
C_R="\033[31m"
C_Y="\033[33m"
C_END="\033[00m"

echo_() {
    echo -e "$1$2$C_END"
}

if [ $# -lt 1 ]; then
    echo_ $C_R "<nom_bridge> absent"
    exit 1
fi
bridgeName=$1

#
#   Création du bridge
#
echo_ $C_G "Création du bridge $1"
ip link add name $bridgeName type bridge    
if [ $? -ne 0 ]; then
    echo_ $C_R "Erreur lors de la création du bridge."
    exit 1
else
    # Si la commande s'est exécutée avec succès, affiche un message de réussite
    echo_ $C_G "Bridge créée."
fi

# Affectation de l'adresse IP du bridge
echo_ $C_Y "Entrez l'adresse IP du bridge : <ip> </mask>"
read ip mask

# Affectation de l'adresse IP au bridge
echo_ $C_G "Affectation de l'ip au bridge"$bridgeName
ip addr add $ip$mask dev $bridgeName
if [ $? -ne 0 ]; then
    echo_ $C_R "Erreur lors de l'affectation de l'ip au bridge."
    exit 1
fi

# Activation du bridge
echo_ $C_G "Activation du bridge"
ip link set dev $bridgeName up
if [ $? -ne 0 ]; then
    echo_ $C_R "Erreur lors de l'activation du bridge."
    exit 1
fi

#
#   Configuration des règles IPTABLES pour le NAT
#   
echo_ $C_G "Configuration des règles iptables"
iptables -t nat -A POSTROUTING -o ens3 -j MASQUERADE
if [ $? -ne 0 ]; then
    echo_ $C_R "Erreur lors de la configuration iptables."
    exit 1
fi


