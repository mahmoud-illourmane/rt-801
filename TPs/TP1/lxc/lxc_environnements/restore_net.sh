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

# Arrêts des conteneurs
echo_ $C_Y "Arrêts des conteneurs"
for container in $(lxc-ls --fancy | awk '{print $1}'); do
    if [ "$container" != "NAME" ]; then
        lxc-stop -n "$container"
        if [ $? -ne 0 ]; then
            echo_ $C_R "Erreur lors de l'arrêt du conteneur $container"
            exit 1
        fi
        echo_ $C_G "Conteneur $container arrêté."
    fi
done

# Suppression de la règle iptables
iptables -t nat -D POSTROUTING -o ens3 -j MASQUERADE
if [ $? -ne 0 ]; then
    echo_ $C_R "Erreur lors de la suppression de la règle iptables."
    exit 1
fi
echo_ $C_G "Règle iptables supprimée."

# Suppression du bridge
ip link delete dev $bridgeName
if [ $? -ne 0 ]; then
    echo_ $C_R "Erreur lors de la suppression du bridge."
    exit 1
fi

exit 0