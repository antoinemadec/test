// https://javascript.info/async-await

// fetch is not implemented in node by default,
// npm install node-fetch --save
const fetch = require("node-fetch");


//--------------------------------------------------------------
// promise/then
//--------------------------------------------------------------
function loadJson(url) {
  return fetch(url)
    .then(response => {
      if (response.status == 200) {
        return response.json();
      } else {
        throw new Error(response.status)
      }
    })
}
//--------------------------------------------------------------


//--------------------------------------------------------------
// async/await
//--------------------------------------------------------------
async function loadJson2(url) {
  let response = await fetch(url)
  if (response.status == 200) {
    return response.json();
  }
  throw new Error(response.status);
}
//--------------------------------------------------------------


async function exec(url) {
  try {
    let r = await loadJson(url)
    console.log("[then]", r)
  } catch (e) {
    console.log("[then]", e)
  }
}

async function exec2(url) {
  try {
    let r = await loadJson2(url)
    console.log("[await]", r)
  } catch (e) {
    console.log("[await]", e)
  }
}

exec('https://no-such-user.json')
exec('https://raw.githubusercontent.com/neoclide/coc.nvim/master/tsconfig.json')
exec2('https://no-such-user.json')
exec2('https://raw.githubusercontent.com/neoclide/coc.nvim/master/tsconfig.json')
console.log('hi')
