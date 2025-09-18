//ClientUDP.java

import java.io.*;
import java.net.*;

public class ClientUDP {
    public static void main(String[] args) throws Exception {
        InetAddress addr = InetAddress.getLocalHost();
        System.out.println("adresse=" + addr.getHostName());

        String s = "Hello World";
        byte[] data = s.getBytes();

        // envoi
        DatagramPacket packet = new DatagramPacket(data, data.length, addr, 1234);
        DatagramSocket sock = new DatagramSocket();
        sock.send(packet);

        // attente de la réponse
        DatagramPacket rep = new DatagramPacket(new byte[1024], 1024);
        sock.receive(rep);
        String str = new String(rep.getData(), 0, rep.getLength());
        System.out.println("recu=" + str);

        sock.close();
    }
}

