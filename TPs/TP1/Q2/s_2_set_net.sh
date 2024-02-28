#!/bin/bash

# Ce script créera un bridge réseau utilisant brctl et configurera une architecture NAT.

BRIDGE_NAME=lxcbr0
BRIDGE_ADDR=10.0.3.1/24
NAT_INTERFACE=$(ip route show default | awk '/default/ {print $5}')

echo "Création du bridge $BRIDGE_NAME..."
sudo brctl addbr $BRIDGE_NAME
sudo ip addr add $BRIDGE_ADDR dev $BRIDGE_NAME
sudo ip link set $BRIDGE_NAME up

echo "Configuration de la NAT..."
sudo iptables -t nat -A POSTROUTING -o $NAT_INTERFACE -j MASQUERADE
sudo iptables -A FORWARD -i $BRIDGE_NAME -j ACCEPT
sudo iptables -A FORWARD -o $BRIDGE_NAME -m state --state RELATED,ESTABLISHED -j ACCEPT

echo "Bridge $BRIDGE_NAME configuré."
