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
file="mafile"

# Nombre de valeurs envoyées à chaque burst
nb_valeurs=1000

# Temps d'attente entre deux bursts
pause=3


# Vérification de la connexion Redis

redis-cli DBSIZE >/dev/null
if ! [ $? = 0 ]
then
    echo "Erreur, pas de connexion avec le serveur redis!"
    exit 1
fi


# Boucle infinie du producteur

# Le producteur fonctionne en continu :
# - il envoie un burst de valeurs
# - il affiche la taille de la file
# - il attend avant de recommencer
while :
do
    echo "=== Nouveau burst de production ==="

    # Envoi de nb_valeurs valeurs aléatoires dans Redis
    for ((compteur=0; compteur<nb_valeurs; compteur++))
    do
        redis-cli LPUSH "$file" "$RANDOM" >/dev/null
    done

    # Taille actuelle de la file
    taille=$(redis-cli --raw LLEN "$file")
    echo "Taille actuelle de la file '$file' : $taille"

    # Pause entre deux bursts
    echo "Pause de ${pause}s avant le prochain burst..."
    sleep "$pause"

done
