<template>
  <section class="container">
     <div>
      <sui-button>Click Here</sui-button>
      <sui-button content="Content as a prop" />
      <div is="sui-button">This is a div</div>
    </div>
  </section>
</template>

<script>
import AppLogo from "~/components/AppLogo.vue";

export default {
  components: {
    AppLogo
  }
};
</script>

<style>
</style>

