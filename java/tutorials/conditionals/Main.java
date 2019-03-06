public class Main {
    public static void main(String[] args) {
        // basics
        int i;
        int result;
        i = 4;
        result =  i == 4 ? 1:8;
        System.out.println("result = " + result);
        i = 0;
        if (i == 4) {
            result = 1;
        } else {
            result = 8;
        }
        System.out.println("result = " + result);

        // difference between == and equals
        String s0 = new String("Wow");
        String s1 = new String("Wow");
        // different from:
        //      String s0 = "Wow";
        //      String s1 = "Wow";
        System.out.println("s0==s1 is " + (s0 == s1));
        System.out.println("s0.equals(s1) is " + s0.equals(s1));

        // exercice
        Main a = new Main() {
            @Override
            public boolean equals(Object obj) {
                return true;
            }
        };
        Main b = a;
        Main c = new Main() {
            @Override
            public boolean equals(Object obj) {
                return false;
            }
        };
        boolean b1 = a == b;
        boolean b2 = b.equals(b + "!");
        boolean b3 = !c.equals(a);
        System.out.println(b1);
        System.out.println(b2);
        System.out.println(b3);
        if (b1 && b2 && b3) {
            System.out.println("Success!");
        }
    }
}
