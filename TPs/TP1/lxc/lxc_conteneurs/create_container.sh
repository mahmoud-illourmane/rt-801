#!/bin/bash

# Usage: ./create_container.sh <cnt_name> <password> <memory> <cpu> <dist> <release> <arch>

C_G="\033[32m"
C_R="\033[31m"
C_Y="\033[33m"
C_END="\033[00m"

echo_() {
    echo -e "$1$2$C_END"
}

# Vérification du nombre de paramètres
if [ "$#" -ne 7 ]; then
    echo -e "\e[1;31mUsage: $0 <cnt_name> <password> <memory> <cpu> <dist> <release> <arch>\e[0m"
    exit 1
fi

NAME=$1
ROOT_PASSWORD=$2
MEMORY=$3
CPU=$4
DIST=$5
RELEASE=$6
ARCH=$7

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
sleep 10

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

echo_ $C_G "Conteneur $NAME créée et configuré."

lxc-stop -n "$NAME"
if [ $? -ne 0 ]; then
    echo_ $C_R "Error lors de l'arrêt du conteneur."
    exit 1
fi
echo_ $C_Y "Conteneur $NAME arrêté."

exit 0