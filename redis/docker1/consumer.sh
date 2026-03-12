#!/bin/bash

# consumer.sh

PARAM=s_redis

# Nom de la file Redis à consommer
file="mafile"

# Seuil d'alerte : si la valeur lue dépasse ce seuil,
seuil=30000

# Durée du traitement spécial en cas d'alerte
pause_traitement=4

# Durée d'attente si la liste est vide
pause_vide=2


# Vérification de la connexion Redis

# Comme Redis est dans un autre conteneur,
# il faut préciser l'hôte avec -h "$PARAM".
redis-cli -h "$PARAM" DBSIZE >/dev/null
if ! [ $? = 0 ]
then
    echo "Erreur, pas de connexion avec le serveur redis!"
    exit 1
fi


# Boucle infinie du consommateur

while :
do
    # LLEN permet de connaître la taille actuelle de la liste.
    # Pour éviter de retirer un élément d'une liste vide.
    nb_elements=$(redis-cli -h "$PARAM" --raw LLEN "$file")

    if [ "$nb_elements" -gt 0 ]
    then
        # RPOP retire un élément de la fin de la liste.
        valeur=$(redis-cli -h "$PARAM" --raw RPOP "$file")

        echo "Valeur lue : $valeur"
        echo "Taille restante de la file '$file' : $(redis-cli -h "$PARAM" --raw LLEN "$file")"

        # Si la valeur dépasse le seuil, on déclenche une alarme
        if [ "$valeur" -gt "$seuil" ]
        then
            echo "ALARME ! Valeur supérieure au seuil : $valeur"
            echo "Traitement pendant ${pause_traitement}s..."
            sleep "$pause_traitement"
        fi
    else
        # Si la liste est vide, on informe l'utilisateur puis on attend.
        echo "Liste vide, attente ${pause_vide}s."
        sleep "$pause_vide"
    fi
done
