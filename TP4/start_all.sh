set -e

echo "Création du réseau Docker..."
./create_network.sh || true

echo "Lancement du conteneur MySQL..."
./run_mysql.sh

echo "Attente que MySQL réponde (simple test ping SQL)..."
try=0
until mysql -u root -p'foo' -h 127.0.0.1 --port=3307 -e "SELECT 1;" >/dev/null 2>&1; do
  try=$((try+1))
  if [ $try -ge 10 ]; then
    echo "MySQL ne répond pas, abandon."
    exit 1
  fi
  sleep 2
done

echo "Remplissage de la base avec data.sql..."
./filldb.sh

echo "Construction de l'image Flask..."
./build_image.sh

echo "Lancement de l'appli Flask..."
./run_app.sh

echo "Tout est lancé. Ouvre ton navigateur sur http://127.0.0.1:5000/"
