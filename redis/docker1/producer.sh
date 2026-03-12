#!/bin/bash

# producer.sh

PARAM=s_redis

# Nom de la file Redis utilisée pour stocker les valeurs
file="mafile"

# Nombre de valeurs envoyées à chaque burst
nb_valeurs=1000

# Temps d'attente entre deux bursts
pause=3


# Vérification de la connexion Redis
# On doit donc préciser l'hôte avec -h $PARAM.

redis-cli -h "$PARAM" DBSIZE >/dev/null
if ! [ $? = 0 ]
then
    echo "Erreur, pas de connexion avec le serveur redis!"
    exit 1
fi


# Boucle infinie du producteur

while :
do
    echo "Nouveau burst de production"

    # Envoi de nb_valeurs valeurs aléatoires dans Redis
    for ((compteur=0; compteur<nb_valeurs; compteur++))
    do
        redis-cli -h "$PARAM" LPUSH "$file" "$RANDOM" >/dev/null
    done

    # Taille actuelle de la file
    taille=$(redis-cli -h "$PARAM" --raw LLEN "$file")
    echo "Taille actuelle de la file '$file' : $taille"

    # Pause entre deux bursts
    echo "Pause de ${pause}s avant le prochain burst..."
    sleep "$pause"

done
