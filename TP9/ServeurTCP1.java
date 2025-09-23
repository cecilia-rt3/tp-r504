
//ServeurTCP1.java

import java.io.*;
import java.net.*;

public class ServeurTCP1
{
	public static void main(String[] args)
	{
        try 
		{
			ServerSocket socketserver = new ServerSocket(2016);
			System.out.println("Serveur en attente...");
							
			Socket socket = socketserver.accept();
			System.out.println("Connexion d'un client");

			DataInputStream dIn = new DataInputStream(socket.getInputStream());
			System.out.println("Message : " + dIn.readUTF());

			socket.close();
			socketserver.close();

        } 
		catch (Exception ex) 
		{
            System.out.println("Erreur côté serveur ");
            ex.printStackTrace();
        }
	}
}

