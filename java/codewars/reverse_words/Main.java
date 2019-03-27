public class Main {
    public static void main(String[] args) {
        String original = "This is an example!";
        System.out.println(reverseWords("This is an example!"));
        System.out.println(reverseWords("   "));
    }
    public static String reverseWords(final String original)
    {
        String r = "";
        String w = "";
        char c;
        for (int i=0; i<original.length(); i++) {
            c = original.charAt(i);
            if (c == ' ') {
                for (int j=w.length()-1; j>=0; j--)
                    r += w.charAt(j);
                r += " ";
                w = "";
            } else {
                w += c;
            }
        }
        for (int j=w.length()-1; j>=0; j--)
            r+=w.charAt(j);
        return r;
    }
}
