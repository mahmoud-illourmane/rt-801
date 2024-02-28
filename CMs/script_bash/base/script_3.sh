#!/bin/bash
echo "Ce script se nomme : " $0
echo "Le premier argument passé est :" $1
./script_1.sh
echo "La dernière commande a donné :" $?
exit 0