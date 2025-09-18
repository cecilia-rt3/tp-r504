//ServeurTCP3.java

import java.io.*;
import java.net.*;

public class ServeurTCP3 {
    public static void main(String[] args) throws Exception {
        ServerSocket socketserver = new ServerSocket(2016);
        while (true) {
            Socket socket = socketserver.accept();

            DataInputStream dIn = new DataInputStream(socket.getInputStream());
            DataOutputStream dOut = new DataOutputStream(socket.getOutputStream());

            String msg = dIn.readUTF();
            System.out.println("Message reçu : " + msg);

            String rev = new StringBuilder(msg).reverse().toString();
            dOut.writeUTF(rev);

            socket.close();
        }
    }
}

