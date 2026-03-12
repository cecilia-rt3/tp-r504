#!/bin/bash

# Stop et suppression des anciens conteneurs
docker stop $(docker ps -q) 2>/dev/null
docker rm $(docker ps -aq) 2>/dev/null


# Création réseau Docker
docker network create myredis


# Build des images
docker build -t img_cons -f Dockerfile_c .
docker build -t img_prod -f Dockerfile_p .


# Lancement consumer
docker run -d \
--network myredis \
--name s_cons \
img_cons


# Lancement producer
docker run -d \
--network myredis \
--name s_prod \
img_prod
