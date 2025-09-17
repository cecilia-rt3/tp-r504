set -e

echo "Arrêt et suppression conteneurs/images..."
./purge.sh || true

echo "[2/2] Purge réseaux/volumes/cache..."
docker network prune -f || true
docker volume prune -f || true
docker system prune -f || true

echo "Nettoyage terminé."
