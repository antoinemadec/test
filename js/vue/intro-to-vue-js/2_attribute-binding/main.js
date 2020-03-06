
var app = new Vue({
  el: '#app', // connects to <div id="app">
  data: {
    product: 'Socks', // connect to {{ product }}
    // v-bind dynamically binds an attribute to an expression:
    //      attribute: src
    //      expression: image
    image: './assets/vmSocks-green-onWhite.jpg',
    altText: "A pair of socks", // <img alt="" is used when image cannot be displayed
    // 'v-bind:attr' can be abbreviated to ':attr'
    link_amazon: 'https://www.amazon.com/s?k=socks&ref=nb_sb_noss',
    link_google: 'https://www.google.com/search?q=socks&sxsrf=ALeKk02wTE5CCqBjrlTDQditWjwuGmcwCg:1583536037453&source=lnms&tbm=isch&sa=X&ved=2ahUKEwiNhYG4-4boAhUDnKwKHaLLDy4Q_AUoAnoECBAQBA&biw=946&bih=254'
  }
})
