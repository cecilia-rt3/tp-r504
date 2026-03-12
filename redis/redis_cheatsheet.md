# Redis client cheatsheet (A COMPLETER!)

Référernces:
- https://en.wikipedia.org/wiki/Redis
- https://redis.io/
  
## 1 - Commandes généralistes

| Commandement  |             |
|---------------|-------------|
| PING          | PONG (test) |
| DBSIZE        | Nombre de clés stockées |
| FLUSHDB       | Effacement de toute la BDD courante |
| FLUSHALL      | Effacement de toutes les BDD |
| EXISTS        | Test de l’existence d’une clé |
| DEL           | Suppression d’une clé |


## 2 - Gestion de valeurs de type "string" (texte ou numérique)

| Commandement  |             |
|---------------|-------------|
| SET           | Donne une valeur à une clé |
| GET           | Récupère la valeur d’une clé |
| INCR          | Incrémente un compteur (+1) |
| INCRBY        | Incrémente un compteur d’une valeur spécifiée |


## 3 - Gestion de listes

| Commandement  |              |
|---------------|-------------|
| LLEN          | Nb d’éléments dans la liste |
| LPUSH         | Ajout d’éléments par la gauche |
| RPUSH         | Ajout d’éléments par la droite |
| LPOP          | Dépilement d’une valeur par la gauche |
| RPOP          | Dépilement d’une valeur par la droite |
| LINDEX        | Lecture d’un élément par son index |
| LRANGE        | Lecture de plusieurs éléments par leurs index |

## 3 - Gestion de Hash (collection de paires clé-valeur)

| Commandement  |              |
|---------------|-------------|
| HLEN          | Nb d’éléments |
| HGET          | Accès à une valeur |
| HINCRBY       | Incrémentation valeur numérique par sa clé |
| HSET          | Ajout paire clé/valeur |
| HKEYS         | Renvoie la liste des clés |
| HVALS         | Renvoie une des valeurs par sa clé |





