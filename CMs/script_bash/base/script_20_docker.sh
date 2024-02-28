#!/bin/bash
echo "Entrez le nom de l'image, le tag et le nom du container :"
read image tag nom_container
echo "Je lance un container Docker avec l'image $image:$tag appelé $nom_container."
docker run --name $nom_container $image:$tag
