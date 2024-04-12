#!/bin/bash

# Ce script supprimera LXC et les utilitaires de bridge.

echo "Désinstallation de LXC et des utilitaires de bridge..."
sudo apt-get remove --purge -y lxc lxc-templates bridge-utils

echo "Nettoyage..."
sudo apt-get autoremove -y

echo "Environnement de conteneur supprimé."
