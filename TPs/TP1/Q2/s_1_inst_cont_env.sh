#!/bin/bash

# Ce script installera LXC, le logiciel de bridge nécessaire et créera un pont réseau spécifique.

echo "Mise à jour des paquets..."
sudo apt-get update

echo "Installation de LXC et des utilitaires de bridge..."
sudo apt-get install -y lxc lxc-templates bridge-utils

echo "Installation terminée."