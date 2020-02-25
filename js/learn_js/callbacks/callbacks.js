var callback = function() {
  console.log("Done (cb)")
}

function regularFunc() {
  console.log("Done (regular)")
}

setTimeout(callback, 1000) // printed last
setTimeout(regularFunc, 900) // printed 2nd
setTimeout(function() {
  console.log("Done (anonymous)")
}, 500) // printed first
