// ES6 implements class keyword
class PersonClass {
  constructor(firstName, lastName) {
    this.firstName = firstName;
    this.lastName = lastName;
  }
  fullName() {
    return this.firstName + " " + this.lastName;
  }
}
// object
var myPersonClass = new PersonClass("Antoine", "Madec")
console.log(myPersonClass.fullName());


// Prior to ES6, we had to use funciton like so:
function Person(firstName, lastName) {
  // constructor
  this.firstName = firstName;
  this.lastName = lastName;

  // method
  this.fullName = function() {
    return this.firstName + " " + this.lastName;
  }
}
// object
var myPerson = new Person("Antoine", "Madec")
console.log(myPerson.fullName());

