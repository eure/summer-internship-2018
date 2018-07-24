<template>
  <div>
    <page-header />
    <nuxt/>
    <page-footer />
  </div>
</template>


<script>
import PageHeader from "~/components/Header.vue";
import PageFooter from "~/components/Footer.vue";

export default {
  name: "default",
  components: {
    PageHeader,
    PageFooter
  }
};
</script>
<style>
</style>

