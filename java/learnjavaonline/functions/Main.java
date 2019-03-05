// ------------------------------------------------------------
// Arguments
// ------------------------------------------------------------
// I always like to say that arguments to Java methods are passed by value,
// although some might disagree with my choice of words, I find it the best way
// to explain and understand how it works exactly.
// By value means that arguments are copied when the method runs. Let's look at
// an example.
//      public void bar(int num1, int num2) {
//          ...
//      }
// You can picture in your head that when bar(a, b) is run, it's like in the
// beginning of bar the following two lines are written:
//      int num1 = a;
//      int num2 = b;
// And only then the rest of the method is run.
// This means that a value get copied to num1 and b value get copied to num2.
// Changing the values of num1 and num2 will not affect a and b.
// If the arguments were objects, the rules remain the same, but it acts a bit
// differently. Here is a an example:
//      public void bar2(Student s1, Student s2) {
//          ...
//      }
// Again we can picture the same two lines in the beginning of bar2
//      Student s1 = joe;
//      Student s2 = jack;
// But when we assign objects, it's a bit different than assigning primitives.
// s1 and joe are two different references to the same object. s1 == joe is
// true. This means that running methods on s1 will change the object joe. But
// if we'll change the value of s1 as a reference, it will not affect the
// reference joe.

// ------------------------------------------------------------
// Non static methods
// ------------------------------------------------------------
// Non static methods in Java are used more than static methods. Those methods
// can only be run on objects and not on the whole class.
// Non static methods can access and alter the field of the object.
//      public class Student {
//          private String name;
//          public String getName() {
//              return name;
//          }
//          public void setName(String name) {
//              this.name = name;
//          }
//      }
// Calling the methods will require an object of type Student.


// Exercise: write the method printFullName of student which prints the full
// name of a student.
class Student {
    private String firstName;
    private String lastName;
    public Student(String firstName, String lastName) {
        this.firstName = firstName;
        this.lastName = lastName;
    }
    public void printFullName() {
        System.out.println(this.firstName + " " + this.lastName);
    }
}
public class Main {
    public static void main(String[] args) {
        Student[] students = new Student[] {
            new Student("Morgan", "Freeman"),
                new Student("Brad", "Pitt"),
                new Student("Kevin", "Spacey"),
        };
        for (Student s : students) {
            s.printFullName();
        }
    }
}
