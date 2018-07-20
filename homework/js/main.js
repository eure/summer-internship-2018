    var vm = new Vue({
        el: '#app',
        data: {
            github: {
                repos:[
                    open=false,
                    change: function (repo) {
                if (repo.open === false) {
                    repo.open = true;
                } else {
                    repo.open = false;
                }
                console.log(repo.open);
            }
                ]
            },
            user: null,
            isVisible: false
        },
        methods: {
            getAPI: function () {
                let user = this.user;
                $.get('https://api.github.com/users/' + user + '/repos').then((repos) => {
                    vm.github.repos = repos;
                    console.log(repos);
                });
            },

        }
    });
        //        change: function(index) {
        //            if(this.github[index].open === false) this.github[index].open = true;
        //            else this.github[index].open = false;
        //            console.log(this.github[index].open);
        //        }



//   change: function () {
//                if (this.github.repos.open === false) {
//                    this.github.repos.open = true;
//                } else {
//                    this.github.repos.open = false;
//                }
//                console.log(this.github.repos.open);
//            }