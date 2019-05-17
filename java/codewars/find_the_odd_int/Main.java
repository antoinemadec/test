import java.util.Hashtable;

public class Main {
    public static void main(String[] args) {
        System.out.println(findIt(new int[]{20,1,-1,2,-2,3,3,5,5,1,2,4,20,4,-1,-2,5}));
        System.out.println(findIt(new int[]{1,1,2,-2,5,2,4,4,-1,-2,5}));
        System.out.println(findIt(new int[]{20,1,1,2,2,3,3,5,5,4,20,4,5}));
        System.out.println(findIt(new int[]{10}));
        System.out.println(findIt(new int[]{1,1,1,1,1,1,10,1,1,1,1}));
        System.out.println(findIt(new int[]{5,4,3,2,1,5,4,3,2,10,10}));
    }
    public static int findIt(int[] a) {
        Hashtable<Integer, Integer> h = new Hashtable<Integer, Integer>();
        for (int i:a)
            h.put(i, (h.getOrDefault(i, 0) + 1));
        for (int k: h.keySet()) {
            if (h.get(k)%2 == 1)
                return k;
        }
        return 0;
    }
}
