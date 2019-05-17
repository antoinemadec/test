public class Main {
    public static void main(String[] args) {
        System.out.println(order("is2 Thi1s T4est 3a"));
        System.out.println(order("Fo1r 4of the2 pe6ople g3ood th5e"));
        System.out.println(order(""));
    }
    public static String order(String words) {
        if (words == "")
            return "";
        String[] str_arr = words.split(" ");
        String[] new_str_arr = new String[str_arr.length];
        for (String w:str_arr)
            new_str_arr[Integer.parseInt(w.replaceAll("[^0-9]+", ""))-1] = w;
        return String.join(" ", new_str_arr);
    }
}
