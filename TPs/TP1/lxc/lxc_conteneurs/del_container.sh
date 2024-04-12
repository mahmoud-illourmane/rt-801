#!/bin/bash

# Usage: ./del_container.sh cnt*

for CONTAINER in $(lxc-ls --filter="$1")
do
  lxc-destroy -n "$CONTAINER"
  echo "Conteneur $CONTAINER supprimé."
done