#!/bin/bash


# Consommateur de données
# Lit les valeurs dans Redis


# Nom de la file
file="mafile"

# Seuil d'alerte
seuil=30000

# Durée du traitement spécial
pause_traitement=4


# Vérification connexion Redis
redis-cli DBSIZE > /dev/null

if ! [ $? = 0 ]
then
    echo "Erreur connexion Redis"
    exit 1
fi


while :
do

    nb=$(redis-cli --raw LLEN $file)

    if [ $nb -gt 0 ]
    then

        valeur=$(redis-cli --raw RPOP $file)

        # echo "Valeur : $valeur"

        if [ $valeur -gt $seuil ]
        then
            # echo "ALERTE $valeur"
            sleep $pause_traitement
        fi

    else

        # Auto destruction si la file est vide
        exit 0

    fi

done
