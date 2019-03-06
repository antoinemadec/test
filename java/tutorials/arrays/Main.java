public class Main {
    public static void main(String[] args) {
        // declare, then create, then assign
        int[] arr;
        arr = new int[10];
        arr[0] = 4;
        arr[1] = arr[0] + 5;
        System.out.println(arr.length);
        System.out.println(arr[0] + arr[1]);
        // one liner: declare and create and assign
        int[] arr2 = {1,2,3};
        System.out.println(arr2[2]);

        // exercise
        int[] numbers = {1, 2, 3, 9};
        int length = numbers[3];
        char[] chars = new char[length];
        chars[numbers.length + 4] = 'y';
        System.out.println("Done!");
    }
}
