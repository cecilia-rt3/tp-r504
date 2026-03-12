#!/bin/bash


# Producteur de données
# Génère des valeurs aléatoires et les envoie dans Redis


# Nom de la file Redis
file="mafile"

# Nombre de valeurs envoyées à chaque burst
nb_valeurs=1000

# Pause entre deux bursts
pause=3


# Vérification connexion Redis
redis-cli DBSIZE > /dev/null

if ! [ $? = 0 ]
then
    echo "Erreur connexion Redis"
    exit 1
fi


# Boucle infinie
while :
do

    for ((i=0;i<nb_valeurs;i++))
    do
        redis-cli LPUSH $file $RANDOM > /dev/null
    done

    # On garde seulement l'affichage de la taille
    taille=$(redis-cli --raw LLEN $file)

    echo "Taille liste : $taille"

    sleep $pause

done
