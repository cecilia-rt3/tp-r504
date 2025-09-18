//ClientTCP3.java

import java.io.*;
import java.net.*;

public class ClientTCP3 {
    public static void main(String[] args) throws Exception {
        Socket socket = new Socket("localhost", 2016);

        DataOutputStream dOut = new DataOutputStream(socket.getOutputStream());
        DataInputStream dIn = new DataInputStream(socket.getInputStream());

        dOut.writeUTF(args[0]);
        String rep = dIn.readUTF();
        System.out.println("Réponse du serveur : " + rep);

        socket.close();
    }
}

