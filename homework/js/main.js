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
        // this.addDetailBotton();
        // console.log(repos);
      });
    }
    //  addDetailBotton: function () {
    //     for (let i = 0; i < vm.github.repos.length; i++) {
    //         vm.github.repos[i].open = false;
    //         vm.github.repos[i].index = i;
    //         console.log(vm.github.repos[i].open);
    //         console.log(vm.github.repos[i].index);
    //     }
    // }
  }
});
