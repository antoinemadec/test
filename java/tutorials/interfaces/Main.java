interface Animal {
    boolean feed(boolean timeToEat);
    void groom();
    void pet();
}

class Dog implements Animal {
    public boolean feed(boolean timeToEat) {
        System.out.println("pour food into bowl");
        return true;
    }
    public void groom() {
        System.out.println("brush well");
    }
    public void pet() {
        System.out.println("pet cautiously");
    }
}

class Giraffe implements Animal {
    public boolean feed(boolean timeToEat) {
        System.out.println("point to the trees");
        return true;
    }
    public void groom() {
        System.out.println("get a ladder");
        System.out.println("brush well");
    }
    public void pet() {
        System.out.println("get a ladder");
        System.out.println("pet cautiously");
    }
}

class Tiger implements Animal {
    public boolean feed(boolean timeToEat) {
        System.out.println("toss raw meat into cage");
        return true;
    }
    public void groom() {
        System.out.println("tranquilize");
        System.out.println("brush well");
    }
    public void pet() {
        System.out.println("DO NOT PET");
    }
}

public class Main {
    public static void main(String[] args) {
        Tiger tiger = new Tiger();
        Giraffe giraffe = new Giraffe();
        Dog dog = new Dog();
        Animal[] animals = new Animal[] {dog, giraffe, tiger};
        for (Animal a : animals) {
            System.out.println("-- new animal");
            System.out.println("---- feed");
            a.feed(true);
            System.out.println("---- pet");
            a.pet();
            System.out.println("---- groom");
            a.groom();
        }
    }
}

