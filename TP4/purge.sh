#purge.sh

# Q2.1 : arrêter + supprimer tous les conteneurs
docker stop $(docker ps -aq)
docker rm   $(docker ps -aq)

# Q2.2 : purger réseaux/volumes/images non utilisés
docker network prune -f
docker volume prune -f
docker image prune -f
