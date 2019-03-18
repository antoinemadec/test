public class Main {
    public static void main(String[] args) {
        GrassHopper o = new GrassHopper();
        System.out.println(o.summation(8));
    }
}

class GrassHopper {
    public static int summation(int n) {
        int s = 0;
        for (int i=1; i<=n; i++)
            s += i;
        return s;
    }
}
