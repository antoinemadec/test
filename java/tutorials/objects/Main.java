// ------------------------------------------------------------
// Public and Private
// ------------------------------------------------------------
// When using the keyword private before a variable or a method, it means only
// the class itself can access the variable or method, when we're using public
// it means everybody can access it. We usually see constructors defined as
// public, variables defined as private and methods are separated, some public
// and some private.

class Point {
    int x;
    int y;
    // constructor
    Point() {
        this(0, 0);
    }
    // constructor overloading
    Point(int x, int y) {
        this.x = x;
        this.y = y;
    }
    // public function
    void printPoint() {
        System.out.println("(" + x + "," + y + ")");
    }
    // public function
    Point center(Point other) {
        // we are using integer, won't get accurate value
        return new Point((x + other.x) / 2, (y + other.y) / 2);
    }
    // Exercise: write a new method in Point called scale, that will make the
    // point closer by half to (0,0). So for example, point (8, 4) after scale
    // will be (4, 2).
    public void scale() {
        this.x >>= 1;
        this.y >>= 1;
    }
}

public class Main {
    public static void main(String[] args) {
        Point p0, p1, p2, center;
        p0 = new Point();
        p1 = new Point(3,6);
        center = p0.center(p1);
        p0.printPoint();
        p1.printPoint();
        center.printPoint();
        p2 = new Point(8,4);
        p2.printPoint();
        p2.scale();
        p2.printPoint();
    }
}

