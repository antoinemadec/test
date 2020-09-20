//-------------------------------------------------------------
// async
//-------------------------------------------------------------
let promise = new Promise(function(resolve, reject) {
  setTimeout(() => resolve("done!"), 1000);
});

// resolve runs the first function in .then
promise.then(
  result => console.log(result), // shows "done!" after 1 second
  error => console.log(error) // doesn't run
);

// if only interested in result:
//  promise.then(only_first_arg)
// if only interested in error:
//  promise.catch(func)
// use promise.finally(func) to apply whether fails or success
//-------------------------------------------------------------

console.log("hi")
