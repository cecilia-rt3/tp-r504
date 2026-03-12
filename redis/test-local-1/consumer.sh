#!/bin/bash

# consumer.sh
# Rôle :
#   Consomme les valeurs présentes dans la file Redis,
#   les affiche, et déclenche un traitement spécial
#   si la valeur dépasse un seuil d'alerte.
#
# Pourquoi ce script :
#   Il simule un micro-service "consommateur" qui lit les messages
#   au rythme qui lui est propre, et traite plus lentement les
#   messages considérés comme critiques.



# Variables de configuration


# Nom de la file Redis à consommer
queue_name="mafile"

# Seuil d'alerte : si la valeur lue dépasse ce seuil,
# un traitement spécial est simulé.
threshold=30000

# Durée du traitement spécial en cas d'alerte
delay_process=4

# Durée d'attente si la liste est vide
delay_empty=2


# Vérification de la connexion Redis

# Comme pour le producteur, on s'assure que Redis est bien joignable
# avant de lancer la boucle infinie.
redis-cli DBSIZE >/dev/null
if ! [ $? = 0 ]
then
    echo "Erreur, pas de connexion avec le serveur redis!"
    exit 1
fi


# Boucle infinie du consommateur

# Le consommateur :
# - vérifie d'abord si la file contient des éléments
# - si elle est vide, il attend
# - sinon, il dépile une valeur, l'affiche, puis teste le seuil
while :
do
    # LLEN permet de connaître la taille actuelle de la liste.
    # On en a besoin pour éviter de dépiler dans une liste vide.
    nb=$(redis-cli --raw LLEN "$queue_name")

    if [ "$nb" -gt 0 ]
    then
        # RPOP retire un élément de la fin de la liste.
        # Comme le producteur empile avec LPUSH, cela permet de
        # traiter les messages dans un ordre cohérent de file.
        value=$(redis-cli --raw RPOP "$queue_name")

        echo "Valeur lue : $value"
        echo "Taille restante de la file '$queue_name' : $(redis-cli --raw LLEN "$queue_name")"

        # Si la valeur dépasse le seuil, on déclenche une alarme
        # et on simule un traitement plus long avec sleep.
        if [ "$value" -gt "$threshold" ]
        then
            echo "ALARME ! Valeur supérieure au seuil : $value"
            echo "Traitement spécial pendant ${delay_process}s..."
            sleep "$delay_process"
        fi
    else
        # Si la liste est vide, on informe l'utilisateur puis on attend.
        echo "Liste vide, attente ${delay_empty}s."
        sleep "$delay_empty"
    fi
done
