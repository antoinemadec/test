import java.util.Hashtable;

public class ProdFib {
    public static long[] productFib(long prod) {
        long a = 0, b = 1, c;
        while (a*b < prod) {
            c = a + b;
            a = b;
            b = c;
        }
        return new long[]{a, b, b*a==prod ? 1:0};
    }
}
