var apiURL = 'https://api.github.com/users/'

Vue.component(
  'modal', {
      template: '#modal-template',
      data: function() {
          return {
              active: false,
              task: {
                  id: '',
                  name: '',
                  detail: '',
                  login:'',
                  id2:'',
                  html_url:'',
                  created_at:'',
                  updated_at:'',
              }
          }
      },
      methods: {
          open: function (task) {
              this.active = true;
              this.task = task;
          },
          close: function () {
              this.active = false;
          }
      },
      mounted: function() {
          this.$nextTick(function () {
              app.$on('open-modal', this.open);
              app.$on('close-modal', this.close);
          }.bind(this));
      }
  });


var app = new Vue({

  el: '#app',

  data: {
    user: null,
    response: null,
    message: 'Hello Vue.js!',
    tasks: [
        {id: 1, name: 'Takehiro Tada', detail: 'response.login'
        ,login:'TakehiroTada',id2:40785892,html_url:'https://github.com/TakehiroTada',created_at:'2018-07-03T06:20:51Z',updated_at:'2018-07-03T06:47:37Z'       
        },
    ]
  },

  watch: {
    user: 'fetchData'
  },

  methods: {
    fetchData: function () {
      let self = this;

      fetch(apiURL + self.user)
        .then(response => response.json())
          .then(data => {
            self.response = data
          });
    },

    openModal: function (task) {
      app.$emit('open-modal', task);
    },

    closeModal: function () {
      app.$emit('close-modal');
    }   

  }
});



// var Hub = new Vue();



// new Vue({
//     el: '#app2',
//     data: {
//         message: 'Hello Vue.js!',
//         tasks: [
//             {id: 1, name: 'let\'s try Vue.js', detail: 'make simple Vue.js app, study how to code vue.js, etc.'},
//             // {id: 2, name: 'learn JavaScript', detail: 'study JS, CoffeeScript, ES6, TypeScript.'}
//         ]
//     },
//     methods: {
//         openModal: function (task) {
//             Hub.$emit('open-modal', task);
//         },
//         closeModal: function () {
//             Hub.$emit('close-modal');
//         }
//     }
// });
