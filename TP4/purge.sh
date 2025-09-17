# Q2.1 : arrêter + supprimer tous les conteneurs
docker stop $(docker ps -aq)
docker rm   $(docker ps -aq)

# Q2.2 : purger réseaux/volumes/images non utilisés
docker system prune -af
docker volume prune -f

