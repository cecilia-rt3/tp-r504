//ServeurUDP.java

import java.io.*;
import java.net.*;

public class ServeurUDP {
    public static void main(String[] args) throws Exception {
        DatagramSocket sock = new DatagramSocket(1234);
        while (true) {
            System.out.println("- Waiting data");
            DatagramPacket packet = new DatagramPacket(new byte[1024], 1024);
            sock.receive(packet);

            String str = new String(packet.getData(), 0, packet.getLength());
            System.out.println("str=" + str);

            // renvoyer au client (écho)
            DatagramPacket echo = new DatagramPacket(
                packet.getData(), packet.getLength(),
                packet.getAddress(), packet.getPort()
            );
            sock.send(echo);
        }
    }
}

