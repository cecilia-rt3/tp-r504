//Clienthttp.java

import java.io.*;
import java.net.*;

public class Clienthttp {
    public static void main(String[] args) throws Exception {
        Socket socket = new Socket(args[0], 80);

        OutputStreamWriter osw = new OutputStreamWriter(socket.getOutputStream());
        InputStreamReader isw = new InputStreamReader(socket.getInputStream());

        BufferedWriter bufOut = new BufferedWriter(osw);
        BufferedReader bufIn = new BufferedReader(isw);

        String request = "GET / HTTP/1.0\r\n\r\n";  // Requête HTTP
        bufOut.write(request, 0, request.length());
        bufOut.flush();

        String line = bufIn.readLine();  // Lecture ligne par ligne
        while (line != null) {           //tant qu'il y a des données reçues,
            System.out.println(line);    // ... les afficher
            line = bufIn.readLine();
        }

        bufIn.close();
        bufOut.close();
        socket.close();
    }
}


/*
Q4.1 : Oui. La commande génère un fichier ur.txt avec une réponse HTTP (302 Found, en-têtes, HTML).

Q4.2 : Oui. Le contenu respecte le protocole HTTP : statut + en-têtes + corps HTML.

Q4.3 : Non. La sortie contient en-têtes + HTML, pas seulement du HTML pur.

Q4.4 : Pas toujours. Certains sites (www.google.com,www.wikipedia.org, ...) renvoient une redirection HTTPS ou exigent HTTP/1.1 + Host.

Q4.5 : Différence car notre client est minimal (GET simple), alors qu’un navigateur envoie plus d’en-têtes et gère HTTPS/redirections.

Q4.6 : En-têtes reçus :
HTTP/1.1 302 Found → ligne de statut : réponse de redirection.

Date - date et heure de la réponse.

Server - logiciel serveur HTTP utilisé (Apache).

Location - URL de redirection (HTTPS)

Content-Length - taille du corps HTML en octets (209).

Connection - gestion de la connexion (fermeture après la réponse).

Content-Type - text/html; charset=iso-8859-1 - type MIME + encodage.

*/

