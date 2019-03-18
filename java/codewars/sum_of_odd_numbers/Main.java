public class Main {
    public static void main(String[] args) {
        RowSumOddNumbers o = new RowSumOddNumbers();
        System.out.println(o.rowSumOddNumbers(1));
        System.out.println(o.rowSumOddNumbers(2));
        System.out.println(o.rowSumOddNumbers(3));
        System.out.println(o.rowSumOddNumbers(42));
    }
}

class RowSumOddNumbers {
    public static int rowSumOddNumbers(int n) {
        return n*n*n;
    }
}
