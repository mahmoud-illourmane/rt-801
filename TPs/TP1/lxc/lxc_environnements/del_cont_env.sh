#!/bin/bash

C_G="\033[32m"
C_R="\033[31m"
C_Y="\033[33m"
C_END="\033[00m"

echo_() {
    echo -e "$1$2$C_END"
}

echo_ $_Y "Suppressions des packages LXC\n"

# Suppression du package lxc-utils
echo_ $_Y "Suppressions du package lxc-utils\n"
apt-get remove lxc-utils
if [ $? -ne 0 ]; then
    echo_ $C_R "Error lors de la suppression du package lxc-utils"
    exit 1
fi

# Suppression du package lxc
echo_ $_Y "Suppressions du package lxc\n"
apt-get remove lxc
if [ $? -ne 0 ]; then
    echo_ $C_R "Error lors de la suppression du package lxc"
    exit 1
fi

