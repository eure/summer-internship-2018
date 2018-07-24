<template>
    <div class = "detail">
      <div v-if="loading">
        <sui-segment>
        <sui-dimmer active inverted>
          <sui-loader />
        </sui-dimmer>
        </sui-segment>
      </div>
        <vue-markdown :source="data"></vue-markdown>
    </div>
</template>


<script>
import axios from "axios";
import VueMarkdown from "vue-markdown";
const url = "http://localhost:3001/detail?data=";
export default {
  components: {
    VueMarkdown
  },
  data() {
    return {
      data: "",
      loading: true
    };
  },
  created() {
    this.GetDetail();
  },
  methods: {
    GetDetail() {
      axios
        .get(url + this.$route.query.title)
        .then(resp => (this.data = resp.data)((this.loading = false)));
    }
  }
};
</script>
