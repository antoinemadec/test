// byte (number, 1 byte)
// short (number, 2 bytes)
// int (number, 4 bytes)
// long (number, 8 bytes)
// float (float number, 4 bytes)
// double (float number, 8 bytes)
// char (a character, 2 bytes)
// boolean (true or false, 1 byte)

public class Main {
    public static void main(String[] args) {
        byte zero = 0;
        short s = 1;
        int i = 3110;
        float f = 2.0f;
        char c = 'H';
        boolean b = true;
        String output = "H" + i + " w" + zero + "r" + s + "d " + f + " " + b;
        System.out.println(output);
    }
}
