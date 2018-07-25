var vm = new Vue({
  el: "#app",
  data: {
    github: {
      repos: []
    },
    user: null,
    isVisible: false
  },
  methods: {
    getAPI: function() {
      let user = this.user;
      $.get("https://api.github.com/users/" + user + "/repos").then(repos => {
        vm.github.repos = repos;
      });
    }
  }
});
