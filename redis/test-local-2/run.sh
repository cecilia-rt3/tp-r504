#!/bin/bash


# Script de monitoring et auto-adaptation
# Lance des consumers selon la charge


# Terminal utilisé
TERM="xfce4-terminal"

# File Redis
file="mafile"

# Compteur d'itération
iteration=0

# Taille précédente
ancienne_taille=0


# Vérification Redis
redis-cli DBSIZE > /dev/null

if ! [ $? = 0 ]
then
    echo "Erreur connexion Redis"
    exit 1
fi


# Lancer le producteur
$TERM -t PRODUCTEUR -e ./producer.sh &


# Boucle de monitoring
while :
do

    taille=$(redis-cli --raw LLEN $file)

    iteration=$((iteration+1))

    jobs=$(jobs | grep Running | wc -l)

    echo "Nb consumers actifs : $jobs"
    echo "iteration $iteration - taille file = $taille"


    # Si la file grossit -> nouveau consumer
    if [ $taille -gt $ancienne_taille ]
    then
        ./consumer.sh &
    fi

    ancienne_taille=$taille

    sleep 3

done
