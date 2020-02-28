var emptyObject = {};
var personObject = {
  firstName : 'John',
  lastName : 'Smith'
}

// in JS, a dictionary is the same as an object
// both '.' and [] can be used
personObject.age = 23;
personObject["salary"] = 14000;

// iteration
for (var member in personObject) {
  if (personObject.hasOwnProperty(member)) {
    console.log(member + ": " + personObject[member]);
  }
}
