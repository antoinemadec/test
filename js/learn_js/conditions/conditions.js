console.log("1" == 1); // true
console.log("1" === 1); // false

function isEqualTo42(n) {
  return n == 42;
}

var myNumber = 42;
if (isEqualTo42(myNumber)) {
  console.log("The number is correct.")
}

var notTrue = false;
if(!notTrue) {
  console.log("not false == true")
}

var str = "antoine";

switch (str) {
  case 'antoine':
    console.log("Cool name");
    break;
  default:
    console.log("ERROR: str unsupported");
    break;
}
