#!/bin/bash

# Usage: ./create_container.sh <cnt_name> <password> <memory> <cpu> <0|newBridge> <dist> <release_name> <arch>

C_G="\033[32m"
C_R="\033[31m"
C_Y="\033[33m"
C_END="\033[00m"

echo_() {
    echo -e "$1$2$C_END"
}

# Vérifie si l'utilisateur est root
if [ "$(id -u)" != "0" ]; then
   echo_ $C_R "Ce script doit être exécuté en tant que root."
   exit 1
fi

# Vérification du nombre de paramètres
if [ "$#" -ne 8 ]; then
    echo_ $C_R "Usage: $0 <cnt_name> <password> <memory> <cpu> <0|newBridge> <dist> <release_name> <arch>"
    exit 1
fi

NAME=$1
ROOT_PASSWORD=$2
MEMORY=$3
CPU=$4
NEW_BRIDGE_NAME=$5
DIST=$6
RELEASE=$7
ARCH=$8

# Validation de la mémoire
if ! [[ "$MEMORY" =~ ^[0-9]+$ ]]; then
    echo_ $C_R "Erreur: La mémoire doit être un nombre."
    exit 2
fi

# Validation du CPU
if ! [[ "$CPU" =~ ^[0-9]+$ ]]; then
    echo_ $C_R "Erreur: Le CPU doit être un nombre."
    exit 3
fi

# Crée le conteneur
if ! lxc-create -n "$NAME" -t download -- -d "$DIST" -r "$RELEASE" -a "$ARCH"; then
    echo_ $C_R "Erreur lors de la création du conteneur."
    exit 4
fi

# Démarrer le conteneur
if ! lxc-start -n "$NAME"; then
    echo_ $C_R "Erreur lors du démarrage du conteneur."
    lxc-destroy -n "$NAME"
    exit 5
fi

# Attendre que le conteneur soit complètement démarré
sleep 5

# Configure le mot de passe root
if ! echo -e "$ROOT_PASSWORD\n$ROOT_PASSWORD" | lxc-attach -n "$NAME" -- passwd; then
    echo_ $C_R "Erreur lors de la configuration du mot de passe root."
    lxc-stop -n "$NAME"
    lxc-destroy -n "$NAME"
    exit 6
fi

# Configure la mémoire et le CPU
if ! echo "lxc.cgroup.memory.limit_in_bytes = ${MEMORY}M" >> /var/lib/lxc/$NAME/config; then
    echo_ $C_R "Erreur lors de la configuration de la mémoire."
    lxc-stop -n "$NAME"
    lxc-destroy -n "$NAME"
    exit 7
fi

if ! echo "lxc.cgroup.cpu.shares = $CPU" >> /var/lib/lxc/$NAME/config; then
    ech_ $C_R "Erreur lors de la configuration du CPU."
    lxc-stop -n "$NAME"
    lxc-destroy -n "$NAME"
    exit 8
fi

if [ "$NEW_BRIDGE_NAME" != 0 ]; then  
    CONFIG_FILE="/var/lib/lxc/$NAME/config"
    echo_ $C_Y "Modification des paramètres réseaux avec le nouveau bridge."
    sed -i "s/lxc.net.0.link = .*/lxc.net.0.link = $NEW_BRIDGE_NAME/" $CONFIG_FILE
    if [ $? -ne 0 ]; then
        echo "Error lors de la configuration du bridge."
        exit 10
    fi
fi

echo_ $C_G "Conteneur $NAME créée et configuré."

lxc-stop -n "$NAME"
if [ $? -ne 0 ]; then
    echo_ $C_R "Error lors de l'arrêt du conteneur."
    exit 10
fi
echo_ $C_Y "Conteneur $NAME arrêté."

exit 0