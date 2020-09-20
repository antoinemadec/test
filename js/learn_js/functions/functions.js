function greet(name) {
  return "Hello " + name
}

console.log(greet("antoine"));

var ptr_anonymous = function(name) {
  return greet(name) + " (anonymous func)"
}

var greet_cpy = greet;

var arrow_func = (name) => {
  return greet(name) + " (arrow func)"
}

console.log(ptr_anonymous("antoine"));
console.log(greet_cpy("antoine"));
console.log(arrow_func("antoine"))
