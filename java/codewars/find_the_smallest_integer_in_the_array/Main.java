import java.util.Arrays;

public class Main {
    public static void main(String[] args) {
        SmallestIntegerFinder o = new SmallestIntegerFinder();
        System.out.println("Hello, World!");
        int[] arr = {34, 15, 88, 2};
        System.out.println(o.findSmallestInt(arr));
    }
}

class SmallestIntegerFinder {
    public static int findSmallestInt(int[] args) {
        Arrays.sort(args);
        return args[0];
    }
}
