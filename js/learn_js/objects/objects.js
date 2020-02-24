var emptyObject = {};
var personObject = {
  firstName : 'John',
  lastName : 'Smith'
}

// both '.' and [] can be used
personObject.age = 23;
personObject["salary"] = 14000;

// iteration
for (var member in personObject) {
  if (personObject.hasOwnProperty(member)) {
    console.log(member + ": " + personObject[member]);
  }
}
