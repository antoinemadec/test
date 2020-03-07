var app = new Vue({
  el: "#app", // connects to <div id="app">
  data: {
    product: "Socks", // connect to {{ product }}
    image: "./assets/vmSocks-green-onWhite.jpg",
    // v-if, v-else-if, v-else: will create/delete elemement each time
    // v-show: keep the element and toggle style="display: none"
    inStock: true,
    details: ["80% cotton", "20% polyester", "Gender-neutral"],
    // v-for "foo in mylist" :key="foo.variantId"
    variants: [
      {
        variantId: 2234,
        variantColor: "green"
      },
      {
        variantId: 2235,
        variantColor: "blue"
      }
    ],
    sizes: ["S", "M", "L", "XL", "XXL", "XXXL"]
  }
});
