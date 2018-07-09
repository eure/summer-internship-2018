<template>
  <div id="content">
    <h1 class="title"><i class="fab fa-github" /> Gitviewer</h1>
    <div class="container">
      <h2>ユーザー詳細</h2>
      <div class="profile">
        <div class="image">
          <p class="img01 waku01"><img :src="avatar" alt="GithubAvatar"/></p>
        </div>
        <div class="profile-text">
          <p>Username:{{user.data.login}}</p>
          <p>Link:<span>Github.com</span></p>
          <p>リポジトリ数：{{user.data.public_repos}}</p>
          <p>作成日時：{{user.data.created_at}}</p>
          <p>最終更新：{{user.data.updated_at}}</p>
        </div>
      </div>
      <div v-for="repo in repos" :key="repo.name">
        {{repo.name}}
        {{repo.description}}
        {{repo.pushed_at}}
        {{repo.language}}
        {{repo.stargazers_count}}
      </div>
    </div>
  </div>
</template>
<script>
import Axios from 'Axios'
export default {
  props:['name'],
  created () {
    const self = this
    Axios.get(`https://api.github.com/users/${this.name}`)
    .then((res) => {
      self.user = res
      self.avatar=res.data.avatar_url
    })
    Axios.get(`https://api.github.com/users/${this.name}/repos`)
    .then((res) => {
      self.repos = res.data
    })
  },
  data(){
    return{
      user:'',
      avatar:'',
      repos:''
    }
  }
}
</script>
>
<style scoped>
@import url('https://fonts.googleapis.com/css?family=Lato:900');
#content{
  font-family: 'Lato', sans-serif;
  position: absolute;
  top :0;
  background: aliceblue;
  background: -webkit-linear-gradient(to right, #00b09b,#96c93d);
  background: linear-gradient(to right, #00b09b,#96c93d);
  width: 100vw;
  height: 100vh
}
.container{
  width: 40vw;
  position: relative;
  top:120px;
  margin :0 auto;
  border-radius: 20px;
  padding: 30px;
  background: aliceblue;
  opacity: 0.9;
}
img{
  width: 100%;
}
.image{
  width:50%;
  float: left;
}
.waku01 {
  clear: both;
  margin:0 auto;
  padding:7px;
  width:50%;
  border:1px solid #ccc;
  background:#fff;
  box-shadow: 1px 1px 5px rgba(20,20,20,0.2);/* ドロップシャドウ 【横位置 縦位置 ぼかし幅 色】の順に記述 */
}
 
.profile{
  width: 100%;
  height: 300px;
}
.profile-text{
  width:50%;
  float: right;
}
h1.title{
  color: azure;
  position: absolute;
  top: 20px;
  left: 20px;;
  margin: 0;
}
h2{
  font-weight: 500;
  color: #00b09b;
  font-family: "Rounded Mplus 1c";
  margin: 30px;
  font-size: 30px;
}
</style>