var app = new Vue({
  el: "#app", // connects to <div id="app">
  data: {
    product: "Socks", // connect to {{ product }}
    // v-bind and : are equivalent
    image: "./assets/vmSocks-green-onWhite.jpg",
    // v-if, v-else-if, v-else: will create/delete elemement each time
    // v-show: keep the element and toggle style="display: none"
    inStock: true,
    details: ["80% cotton", "20% polyester", "Gender-neutral"],
    // v-for "foo in mylist" :key="foo.variantId"
    variants: [
      {
        variantId: 2234,
        variantColor: "green",
        // v-on and @ are equivalent
        variantImage: "./assets/vmSocks-green-onWhite.jpg"
      },
      {
        variantId: 2235,
        variantColor: "blue",
        variantImage: "./assets/vmSocks-blue-onWhite.jpg"
      }
    ],
    cart: 0
  },
  methods: {
    // anonymous functions: supported by all browsers
    // named functions: not supported by all browsers
    addToCart: function() {
      this.cart ++
    },
    removeFromCart: function() {
      if (this.cart > 0) {
        this.cart --
      }
    },
    updateProduct: function(variantImage) {
      this.image = variantImage
    }
  }
});
