#!/bin/bash

# consumer.sh
# Lit les valeurs dans la file Redis et déclenche une alerte si le seuil est dépassé.


# Nom de la file Redis à consommer
file="mafile"

# Seuil d'alerte : si la valeur lue dépasse ce seuil,
# un traitement spécial est simulé.
seuil=30000

# Durée du traitement spécial en cas d'alerte
pause_traitement=4

# Durée d'attente si la liste est vide
pause_vide=2


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
    nb_elements=$(redis-cli --raw LLEN "$file")

    if [ "$nb_elements" -gt 0 ]
    then
        # RPOP retire un élément de la fin de la liste.
        valeur=$(redis-cli --raw RPOP "$file")

        echo "Valeur lue : $valeur"
        echo "Taille restante de la file '$file' : $(redis-cli --raw LLEN "$file")"

        # Si la valeur dépasse le seuil, on déclenche une alarme
        if [ "$valeur" -gt "$seuil" ]
        then
            echo "ALARME ! Valeur supérieure au seuil : $valeur"
            echo "Traitement spécial pendant ${pause_traitement}s..."
            sleep "$pause_traitement"
        fi
    else
        # Si la liste est vide, on informe l'utilisateur puis on attend.
        echo "Liste vide, attente ${pause_vide}s."
        sleep "$pause_vide"
    fi
done
