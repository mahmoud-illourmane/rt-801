#!/bin/bash

# Ce script supprimera le bridge créé par set_net.sh et nettoiera les règles iptables ajoutées.

BRIDGE_NAME=lxcbr0

echo "Destruction du bridge $BRIDGE_NAME..."
sudo ip link set $BRIDGE_NAME down
sudo brctl delbr $BRIDGE_NAME

echo "Nettoyage des règles iptables..."
sudo iptables -t nat -D POSTROUTING -o $(ip route show default | awk '/default/ {print $5}') -j MASQUERADE
sudo iptables -D FORWARD -i $BRIDGE_NAME -j ACCEPT
sudo iptables -D FORWARD -o $BRIDGE_NAME -m state --state RELATED,ESTABLISHED -j ACCEPT

echo "Restauration du réseau terminée."
