import Vue from 'vue'
import Router from 'vue-router'
import HelloWorld from '@/components/HelloWorld'
import User from '@/components/User'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'HelloWorld',
      component: HelloWorld
    },
    {
      path: '/user/:name',
      name: 'User',
      component: User,
      props: true
    },
    {
      path: '/user/',
      name: 'HelloWorld',
      component: HelloWorld,
    }
  ]
})
