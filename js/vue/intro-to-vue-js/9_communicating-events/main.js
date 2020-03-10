Vue.component("product", {
  props: {
    premium: {
      type: Boolean,
      required: true
    }
  },
  template: `
    <div class="product">
      <div class="product-image">
        <img v-bind:src="image" />
      </div>

      <div class="product-info">
        <h1>{{ title }}</h1>

        <p v-if="inStock">In Stock</p>
        <p v-else >Out of Stock</p>
        <p>Shipping: {{ shipping }}</p>

        <ul>
          <li v-for="detail in details">{{ detail }}</li>
        </ul>

        <div v-for="(variant, index) in variants"
             :key="variant.variantId"
             class="color-box"
             :style="{backgroundColor: variant.variantColor}"
             @mouseover="updateProduct(index)" >
        </div>

        <button v-on:click="addToCart"
                :disabled="!inStock"
                :class="{ disabledButton: !inStock }"
          >Add to Cart<br></br> </button>

        <button v-on:click="removeFromCart"
                :disabled="!inStock"
                :class="{ disabledButton: !inStock }"
          >Remove from Cart<br></br> </button>
      </div>
    </div>
`,
  // data() is a function to create new data for each component
  data() {
    return {
      brand: "Chaud-7™",
      product: "Socks",
      selectedVariant: 0,
      details: ["80% cotton", "20% polyester", "Gender-neutral"],
      variants: [
        {
          variantId: 2234,
          variantColor: "green",
          variantImage: "./assets/vmSocks-green-onWhite.jpg",
          variantQuantity: 10
        },
        {
          variantId: 2235,
          variantColor: "blue",
          variantImage: "./assets/vmSocks-blue-onWhite.jpg",
          variantQuantity: 2
        }
      ]
    };
  },
  computed: {
    title() {
      return this.brand + " " + this.product;
    },
    image() {
      return this.variants[this.selectedVariant].variantImage;
    },
    inStock() {
      return this.variants[this.selectedVariant].variantQuantity > 0;
    },
    shipping() {
      return this.premium ? "Free" : "2.99";
    }
  },
  methods: {
    addToCart() {
      // component 'product' emits 'add-to-cart' to communicate whith its parent
      this.$emit("add-to-cart", this.variants[this.selectedVariant].variantId);
    },
    removeFromCart() {
      this.$emit("remove-from-cart", this.variants[this.selectedVariant].variantId);
    },
    updateProduct(index) {
      this.selectedVariant = index;
    }
  }
});

var app = new Vue({
  el: "#app", // connects to <div id="app">
  data: {
    premium: true,
    cart: []
  },
  methods: {
    updateCartAdd(id) {
      this.cart.push(id);
    },
    updateCartRemove(id) {
      for (var i = 0; i < this.cart.length; i++) {
        if (this.cart[i] == id) {
          this.cart.splice(i,1)
          return
        }
      }
    }
  }
});
