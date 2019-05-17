public class Main {
    public static void main(String[] args) {
        RemoveChars o = new RemoveChars();
        System.out.println(o.remove("coucou"));
    }
}

class RemoveChars {
    public static String remove(String str) {
        return str.substring(1,str.length()-1);
    }
}
