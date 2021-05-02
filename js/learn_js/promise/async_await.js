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


async function execThen(url) {
  try {
    let r = await loadJson(url)
    console.log("[then]", r)
  } catch (e) {
    console.log("[then]", e)
  }
}

async function execAwait(url) {
  try {
    let r = await loadJson2(url)
    console.log("[await]", r)
  } catch (e) {
    console.log("[await]", e)
  }
}

async function main() {
  execThen('https://no-such-user.json')
  execThen('https://raw.githubusercontent.com/neoclide/coc.nvim/master/tsconfig.json')
  execAwait('https://no-such-user.json')
  execAwait('https://raw.githubusercontent.com/neoclide/coc.nvim/master/tsconfig.json')
  console.log('hi')
}

main()
