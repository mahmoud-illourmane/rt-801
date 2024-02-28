#!/bin/bash

# Vérification du nombre de paramètres
if [ "$#" -ne 5 ]; then
    echo "Je dois recevoir exactement 5 paramètres : Nom de l'hôte, Identifiant de la carte réseau, Adresse de la carte réseau, Adresse de la passerelle, Adresse du DNS"
    exit 1
fi

# Affectation des paramètres à des variables pour une meilleure lisibilité
NOM_HOTE=$1                 # Ex : toto
ID_CARTE_RESEAU=$2          # Ex : ens3/eth0
ADRESSE_CARTE=$3            # Ex : 10.11.0.17/28
ADRESSE_PASSERELLE=$4       # Ex : 10.0.11.80
ADRESSE_DNS=$5              # Ex : [8.8.8.8, 8.8.4.4]

# 1. Affectation du nom de l'hôte
echo "Je modifie le nom de l'hôte en $NOM_HOTE."
sudo hostnamectl set-hostname $NOM_HOTE
echo -e "\e[1;31mUn redémarrage est nécessaire pour voir le changement\e[0m"

# 2. Vérification de l'existence de l'interface réseau
if ! ip link show $ID_CARTE_RESEAU > /dev/null 2>&1; then
    echo "\e[1;31mL'interface réseau $ID_CARTE_RESEAU n'existe pas. Je termine le script.\e[0m"
    exit 2
fi

# 3. Désactivation de la carte réseau (interface réseau)
echo "\e[1;31mJe désactive l'interface réseau $ID_CARTE_RESEAU.\e[0m"
sudo ip link set dev $ID_CARTE_RESEAU down

# 4. Modification de l'adresse de la carte réseau
echo "\e[1;31mJe configure l'adresse IP de l'interface $ID_CARTE_RESEAU à $ADRESSE_CARTE.\e[0m"
sudo ip addr add $ADRESSE_CARTE dev $ID_CARTE_RESEAU

# 5. Activation de l'interface réseau, et si nécessaire du service réseau
echo "\e[1;31mJ'active l'interface réseau $ID_CARTE_RESEAU...\e[0m"
sudo ip link set dev $ID_CARTE_RESEAU up

# Vérification si NetworkManager est installé
# if systemctl list-unit-files | grep -qw NetworkManager.service; then
#     echo "NetworkManager est installé."
    
#     # Vérification si NetworkManager est actif
#     if ! systemctl is-active --quiet NetworkManager; then
#         echo "Le service réseau NetworkManager n'est pas actif. Je l'active..."
#         sudo systemctl start NetworkManager
#     else
#         echo "Le service réseau NetworkManager est déjà actif."
#     fi
# else
#     echo "NetworkManager n'est pas installé. Je ne peux pas l'activer."
# fi

# 6. Modification de l'adresse du DNS
echo "Je configure l'adresse du DNS à $ADRESSE_DNS..."
echo "nameserver $ADRESSE_DNS" | sudo tee /etc/resolv.conf > /dev/null

# 7. Test de connexion au réseau
echo "Je teste la connexion au réseau..."
ping -c 4 8.8.8.8 > /dev/null

# Si ping retourne 0 alors le ping a fonctionné
if [ $? -eq 0 ]; then
    echo "La connexion au réseau est réussie."
else
    echo "Je n'ai pas pu établir de connexion au réseau. Vérifiez les configurations."
    exit 3
fi

exit 0