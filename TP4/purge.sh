# Q2.1 - deux lignes (arrête et supprime tous les conteneurs/images)
docker rm -f $(docker ps -aq) 2>/dev/null
docker rmi -f $(docker images -q) 2>/dev/null

# Q2.2 - purge des réseaux/volumes/etc.
docker network prune -f
docker volume prune -f
docker system prune -f
