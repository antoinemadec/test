// inheritance refers to the adoption of all non-private properties and methods
// of one class (superclass) by another class (subclass). Inheritance is a way
// to make a copy of an existing class as the starting point for another. In
// addition to the term subclass, inherited classes are also called derived
// classes.

// Exercise Create a house front door class which inherits from the Door class
// and open it. Assume the house door has a locked doorknob and it swings into
// the house. Hint: Your code should use the super keyword.
class Door {
    public void open () {
        System.out.println("push door");
    }
}

class HouseFrontDoor extends Door {
    public void open () {
        System.out.println("unlock door");
        super.open();
    }
}

public class Main {
    public static void main(String[] args) {
        Door d1 = new HouseFrontDoor();
        d1.open();
    }
}
