#!/bin/bash

# Usage: ./create_container.sh <cnt_name> <password> <memory> <cpu> <dist> <release> <arch>

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
    echo -e "\e[1;31mErreur: La mémoire doit être un nombre.\e[0m"
    exit 2
fi

# Validation du CPU
if ! [[ "$CPU" =~ ^[0-9]+$ ]]; then
    echo -e "\e[1;31mErreur: Le CPU doit être un nombre.\e[0m"
    exit 3
fi

# Crée le conteneur
if ! lxc-create -n "$NAME" -t download -- -d "$DIST" -r "$RELEASE" -a "$ARCH"; then
    echo -e "\e[1;31mErreur lors de la création du conteneur.\e[0m"
    exit 4
fi

# Démarrer le conteneur
if ! lxc-start -n "$NAME"; then
    echo -e "\e[1;31mErreur lors du démarrage du conteneur.\e[0m"
    lxc-destroy -n "$NAME"
    exit 5
fi

# Attendre que le conteneur soit complètement démarré
sleep 10 # Considérer une approche plus dynamique pour vérifier l'état

# Configure le mot de passe root
if ! echo -e "$ROOT_PASSWORD\n$ROOT_PASSWORD" | lxc-attach -n "$NAME" -- passwd; then
    echo -e "\e[1;31mErreur lors de la configuration du mot de passe root.\e[0m"
    lxc-stop -n "$NAME"
    lxc-destroy -n "$NAME"
    exit 6
fi

# Configure la mémoire et le CPU
if ! echo "lxc.cgroup.memory.limit_in_bytes = ${MEMORY}M" >> /var/lib/lxc/$NAME/config; then
    echo -e "\e[1;31mErreur lors de la configuration de la mémoire.\e[0m"
    lxc-stop -n "$NAME"
    lxc-destroy -n "$NAME"
    exit 7
fi

if ! echo "lxc.cgroup.cpu.shares = $CPU" >> /var/lib/lxc/$NAME/config; then
    echo -e "\e[1;31mErreur lors de la configuration du CPU.\e[0m"
    lxc-stop -n "$NAME"
    lxc-destroy -n "$NAME"
    exit 8
fi

echo "Conteneur $NAME créé et configuré."

# Assurez-vous de stopper le conteneur si nécessaire ou de le laisser tourner selon votre besoin
lxc-stop -n "$NAME"

exit 0