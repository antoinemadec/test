
var app = new Vue({
  el: '#app', // connects to <div id="app">
  data: {
    product: 'Socks', // connect to {{ product }}
    image: './assets/vmSocks-green-onWhite.jpg',
    // v-if, v-else-if, v-else: will create/delete elemement each time
    // v-show: keep the element and toggle style="display: none"
    inventory: 10,
    onSale: true
  }
})
