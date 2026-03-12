#!/bin/bash

# producer.sh
# Rôle :
#   Produit des valeurs numériques aléatoires et les envoie
#   dans une liste Redis jouant le rôle de file de messages.
#
# Pourquoi ce script :
#   Il simule un micro-service "producteur" qui génère beaucoup
#   de données, puis attend avant de recommencer.


# Variables de configuration

# Nom de la file Redis utilisée pour stocker les valeurs
queue_name="mafile"

# Nombre de valeurs envoyées à chaque burst
burst_size=1000

# Temps d'attente entre deux bursts
delay_burst=3


# Vérification de la connexion Redis

# On teste Redis avant de commencer.
# Si la commande redis-cli DBSIZE échoue, cela signifie que le serveur
# Redis n'est pas accessible, donc le script s'arrête proprement.
redis-cli DBSIZE >/dev/null
if ! [ $? = 0 ]
then
    echo "Erreur, pas de connexion avec le serveur redis!"
    exit 1
fi


# Boucle infinie du producteur

# Le producteur fonctionne en continu :
# - il envoie un burst de 1000 valeurs
# - il affiche la taille de la file
# - il attend 3 secondes
while :
do
    echo "=== Nouveau burst de production ==="

    # Cette boucle envoie burst_size valeurs aléatoires dans Redis.
    # LPUSH ajoute chaque nouvelle valeur en tête de la liste.
    for ((i=0; i<burst_size; i++))
    do
        redis-cli LPUSH "$queue_name" "$RANDOM" >/dev/null
    done

    # Affiche la taille actuelle de la file après le burst.
    size=$(redis-cli --raw LLEN "$queue_name")
    echo "Taille actuelle de la file '$queue_name' : $size"

    # Pause demandée par l'énoncé entre deux bursts.
    echo "Pause de ${delay_burst}s avant le prochain burst..."
    sleep "$delay_burst"
done
