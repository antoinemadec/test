var app = new Vue({
  el: "#app", // connects to <div id="app">
  data: {
    brand: 'Chaud-7™',
    product: "Socks", // connect to {{ product }}
    // v-bind and : are equivalent
    selectedVariant: 0,
    // v-if, v-else-if, v-else: will create/delete elemement each time
    // v-show: keep the element and toggle style="display: none"
    details: ["80% cotton", "20% polyester", "Gender-neutral"],
    // v-for "foo in mylist" :key="foo.variantId"
    variants: [
      {
        variantId: 2234,
        // style binding
        //  :style="{ cssProperty: vueVariable }"
        //  :style="vueStyleObject"
        //  :style="[vueStyleObject, vueStyleObject2]"
        // class binding
        //  :class="{ cssClassName: vueCondition }"
        //  :class="vueClassObject"
        //  :class="[vueClassObject, vueClassObject2]"
        //  :class="[vueCondition ? vueCssClassName : '']"
        variantColor: "green",
        // v-on and @ are equivalent
        variantImage: "./assets/vmSocks-green-onWhite.jpg",
        variantQuantity: 10
      },
      {
        variantId: 2235,
        variantColor: "blue",
        variantImage: "./assets/vmSocks-blue-onWhite.jpg",
        variantQuantity: 0
      }
    ],
    cart: 0
  },
  computed: {
    // computed properties are cached and is only updated when 1 dependency change
    // it is more efficient to use computed properties than method when possible
    title() {
      return this.brand + ' ' + this.product
    },
    image() {
      return this.variants[this.selectedVariant].variantImage
    },
    inStock() {
      return this.variants[this.selectedVariant].variantQuantity > 0
    }
  },
  methods: {
    // anonymous functions: supported by all browsers
    // named functions: not supported by all browsers
    addToCart() {
      this.cart ++
    },
    updateProduct(index) {
      this.selectedVariant = index
    }
  }
});
