#!/bin/bash
set -x
#Création du reseau  nommé tplb
docker network create tplb

#Construction de l’image
docker build -t im-nginx-lb ./tp-A 

#Création de deux sous-dossiers shared1 et shared2 
mkdir -p shared1 shared2

#Fichiers html
echo "<h1>Hello 1</h1>" > shared1/index.html
echo "<h1>Hello 2</h1>" > shared2/index.html

#Lancement des deux conteneurs basé sur l’image nginx,nginx1 et nginx2
docker run -d --rm --name nginx1 --network tplb -p 81:80 \
	-v "$(pwd)/shared1:/usr/share/nginx/html" \
	nginx:latest

docker run -d --rm --name nginx2 --network tplb -p 82:80 \
	-v "$(pwd)/shared2:/usr/share/nginx/html" \
	nginx:latest

#Lancement
docker run -d --rm --name nginx-lb --network tplb  -p 83:80  im-nginx-lb


# option -s de curl: -s de curl signifie silent (silencieux).
#Elle sert à masquer les messages de progression et les erreurs par défaut.
for i in $(seq 1 500); do
  curl -s http://localhost:83 >> rep.txt
  echo "" >> rep.txt
done

echo "Nombre de réponses Hello 1 :"
grep -c "Hello 1" rep.txt

echo "Nombre de réponses Hello 2 :"
grep -c "Hello 2" rep.txt

