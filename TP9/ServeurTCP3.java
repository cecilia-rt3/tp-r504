
//ServeurTCP3.java

import java.io.*;
import java.net.*;


public class ServeurTCP3
{
    public static void main(String[] args)
		{
        try
		{
            while (true)
			{
                ServerSocket socketserver = new ServerSocket(2016);
                System.out.println("Serveur en attente...");

                Socket socket = socketserver.accept();
                System.out.println("Connexion d'un client");

                DataInputStream dIn = new DataInputStream(socket.getInputStream());
                DataOutputStream dOut = new DataOutputStream(socket.getOutputStream());

                // lire et stocker le message
                String msg = dIn.readUTF();
                System.out.println("Message : " + msg);

                // inversion
                String rev = new StringBuilder(msg).reverse().toString();

                // renvoyer la chaîne inversée
                dOut.writeUTF(rev);

                socket.close();
                socketserver.close();
            }

        } catch (Exception ex) 
			{
            System.out.println("Erreur côté serveur ");
            ex.printStackTrace();

        }
    }
}

