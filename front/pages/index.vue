<template>
  <div class="container">
    <div v-if="loading">
      <sui-segment>
      <sui-dimmer active inverted>
        <sui-loader />
      </sui-dimmer>

      </sui-segment>
    </div>

  <sui-list divided relaxed v-for="result in this.results" :key='result'>
      <sui-list-item>
        <sui-list-icon name="github" size="large" vertical-align="middle" />
        <sui-list-content>
          <a is="sui-header" v-bind:href="result.url">{{ result.title }}</a>
          <a is="sui-list-description">{{ result.description}}</a>
          <a v-bind:href="'/detail?title=' + result.title">see detail</a>
        </sui-list-content>
      </sui-list-item>
      <sui-divider clearing />
  </sui-list>
  </div>
</template>

<script>
import axios from "axios";
const base_url = "http://localhost:3001/get";
export default {
  data() {
    return {
      results: [],
      loading: true,
      url: "aaa"
    };
  },
  created() {
    this.SendRequest(base_url);
  },
  methods: {
    SendRequest(url) {
      axios
        .get(url)
        .then(resp => ((this.results = resp.data), (this.loading = false)));
    }
  }
};
</script>

<style>
</style>

