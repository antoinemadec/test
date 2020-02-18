// stack:
//  push = push_back
//  pop = pop_back
console.log('-- stack');
var myStack = [];
myStack.push(1);
myStack.push(2);
myStack.push(3);
console.log(myStack);
console.log(myStack.pop());
console.log(myStack);

// queue:
//  push = push_back
//  shift = pop_front
console.log('-- queue');
var myQueue = [];
myQueue.push(1);
myQueue.push(2);
myQueue.push(3);
console.log(myQueue.shift());
console.log(myQueue.shift());
console.log(myQueue.shift());

// unshift = push_front
console.log('-- unshift');
var myArray = [1,2,3];
myArray.unshift(0);
console.log(myArray);       // will print out 0,1,2,3

// splice = remove indexes
console.log('-- splice');
var myArray = [0,1,2,3,4,5,6,7,8,9];
var splice = myArray.splice(3,5);
console.log(splice);        // will print out 3,4,5,6,7
console.log(myArray);       // will print out 0,1,2,8,9

