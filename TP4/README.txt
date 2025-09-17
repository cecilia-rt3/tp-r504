TP4 — Mise en place d’une application Web dynamique (Flask + MySQL) — R504
===========================================================================

Ce dossier contient TOUT ce qu’il faut pour répondre au TP (Q2.1 → Q2.13) en scripts Bash simples,
plus deux fichiers Docker Compose en bonus pour comparaison.

Arborescence (principaux fichiers)
----------------------------------
- purge.sh                  # Q2.1 + Q2.2 : arrêt/suppression + prune
- create_network.sh         # Q2.3 : créer le réseau net-tp4
- run_mysql.sh              # Q2.4 : lancer MySQL sur 3307→3306
- data.sql                  # Q2.5 : créer/remplir la BDD (1 table)
- filldb.sh                 # Q2.6 : remplir la BDD (mysql CLI)
- Dockerfile1               # Q2.8 : image Debian11 + paquets + Flask + MySQL client Python + copies
- build_image.sh            # Q2.9 : build im-tp4
- run_app.sh                # Q2.10 : lancer l’app Flask (tp4-app)
- index.html                # page HTML (Jinja) pour le dump de la table
- app_1.py                  # app Flask corrigée (connexion par requête, évite l’erreur F5) — Q2.12
- Dockerfile2               # Q2.13 : variante DEV (sans COPY du .py)
- build_image2.sh           # Q2.13 : build im-tp4-dev
- run_app_dev.sh            # Q2.13 : run avec bind mount ./srv → /srv
- srv/app1.py               # code Python (pour le bind mount en DEV)
- start_all.sh              # Script maître (intro) : enchaîne Q2.3→Q2.10
- stop_all.sh               # Script maître (intro) : arrêt/nettoyage
- docker-compose.yml        # BONUS : équivalent prod simple (Dockerfile1)
- docker-compose.dev.yml    # BONUS : équivalent dev (Dockerfile2 + bind mount)

Prérequis
---------
- Docker et client MySQL installés (sur Linux ou dans une VM Debian 11).
- Ports disponibles : 3307 (MySQL hôte) et 5000 (Flask).

Mode scripts Bash (rendu officiel du TP)
----------------------------------------
1) Ouvrir un terminal dans le dossier TP4/ (là où se trouvent les .sh).
2) Rendre exécutables :    chmod +x *.sh
3) Démarrer tout :         ./start_all.sh
   - Le script crée le réseau, lance MySQL, attend qu’il réponde, remplit la BDD,
     construit l’image Flask puis lance l’app.
4) Tester dans le navigateur :  http://127.0.0.1:5000/
5) Quand terminé :          ./stop_all.sh   (arrêt + nettoyage)

Utilisation manuelle (étape par étape)
--------------------------------------
# Q2.3
./create_network.sh
# Q2.4
./run_mysql.sh
# Q2.6 (après Q2.5 data.sql)
./filldb.sh
# Q2.9
./build_image.sh
# Q2.10
./run_app.sh
# Q2.11
Naviguer sur http://127.0.0.1:5000/
# Q2.12
(Erreur interne au F5 corrigée dans app_1.py — si tu modifies app_1.py, rebuild + relance)
./build_image.sh && ./run_app.sh
git tag v1.0
# Q2.13 (mode dev, sans rebuild à chaque modif)
./build_image2.sh
./run_app_dev.sh
# Puis éditer srv/app1.py et rafraîchir le navigateur

Mode Compose (bonus, facultatif)
--------------------------------
# PROD simple (Dockerfile1)
docker compose up -d --build
# DEV (Dockerfile2 + bind mount ./srv:/srv)
docker compose -f docker-compose.dev.yml up -d --build
# Logs
docker compose logs -f --tail 50
# Stop/cleanup
docker compose down

Désinstallation / Nettoyage global
----------------------------------
- Avec le script maître :
  ./stop_all.sh
- Ou directement :
  ./purge.sh

Notes
-----
- Le conteneur MySQL s’appelle « mysql » et tourne sur le réseau Docker « net-tp4 ».
- L’app Flask s’appelle « tp4-app » (ou « tp4-app-dev » en mode dev).
- Le code Python se connecte à MySQL via host='mysql', user='root', password='foo', database='tp4db'.
- En mode dev (bind mount), le fichier Python se trouve côté hôte dans ./srv/app1.py.

Bon TP !
