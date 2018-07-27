<template>
  <div id="content">
    <h1 class="title" @click="$router.push({path:`/user`})"><i class="fab fa-github" /> Gitviewer</h1>
    <div v-if="!(selected==null)" id="dialog">
      <div id="dialogCard">
          <p class="img01 waku01"><img :src="avatar" alt="GithubAvatar"/></p>
        <p>{{selected.name}}</p>
        <p>{{selected.description}}</p>
        <p>lang  :{{selected.language}}</p>
        <p>push  :{{selected.pushed_at}}</p>
        <p>update:{{selected.updated_at}}</p>
        <p>star  :{{selected.stargazers_count}}</p>
        <p>fork  :{{selected.forks_count}}</p>
        <p>owner :{{selected.owner.login}}</p>
        <button @click="selected=null">close</button>
      </div>
    </div>
    <div class="container">
      <h2>ユーザー詳細</h2>
      <div class="profile">
        <div class="image">
          <p class="img01 waku01"><img :src="avatar" alt="GithubAvatar"/></p>
        </div>
        <div class="profile-text">
          <table>
            <tbody>
              <tr>
                <th>Username:</th>
                <td>{{user.data.login}}</td>
              </tr>
              <tr>
                <th>リポジトリ数：</th>
                <td>{{user.data.public_repos}}</td>
              </tr>
              <tr>
                <th>作成日時：</th>
                <td>{{user.data.created_at}}</td>
              </tr>
              <tr>
                <th>最終更新：</th>
                <td>{{user.data.updated_at}}</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
      <div id="cardList">
        <repo-card v-for="repo in repos" :key="repo" :repo="repo" class="card" @set="goDetail"/>
      </div>
    </div>
  </div>
</template>
<script>
import Axios from "axios";
import repoCard from "./repoCard";
export default {
  props: ["name"],
  components: {
    repoCard
  },
  methods:{
    goDetail(name){
      console.log(name)
      this.selected=name;
    }
  },
  created() {
    const self = this;
    Axios.get(`https://api.github.com/users/${this.name}`).then(res => {
      self.user = res;
      self.avatar = res.data.avatar_url;
    });
    Axios.get(`https://api.github.com/users/${this.name}/repos`).then(res => {
      self.repos = res.data;
    });
  },
  data() {
    return {
      user: "",
      avatar: "",
      repos: "",
      selected:null
    };
  }
};
</script>
>
<style scoped>
@import url("https://fonts.googleapis.com/css?family=Lato:900");
::-webkit-scrollbar {
  width: 10px;
}
::-webkit-scrollbar-track {
  border-radius: 10px;
  box-shadow: inset 0 0 5px rgba(0, 0, 0, 0.1);
}
::-webkit-scrollbar-thumb {
  background-color: rgba(0, 0, 50, 0.5);
  border-radius: 10px;
  box-shadow: 0 0 0 1px rgba(255, 255, 255, 0.3);
}
#dialog{
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right:0;
  background: rgba(0, 0, 0, 0.4);
  z-index: 500;
}
#dialogCard{
  width: 35vw;
  height: 70vh;
  position: relative;
  top: 140px;
  margin: 0 auto;
  border-radius: 10px;
  padding: 30px;
  background: aliceblue;
  opacity: 0.9;
  z-index: 600;
}
#content {
  font-family: "Lato", sans-serif;
  position: absolute;
  top: 0;
  background: aliceblue;
  background: -webkit-linear-gradient(to right, #00b09b, #96c93d);
  background: linear-gradient(to right, #00b09b, #96c93d);
  width: 100vw;
  height: 100vh;
}
#cardList {
  height: 42vh;
  width: 100%;
  display: flex;
  flex-wrap: wrap;
  justify-content: space-around;
  align-items: flex-start;
  align-content: flex-start;
  overflow: auto;
}
.card {
  flex: 0 1 45%;
  height: 10vh;
  margin-top: 20px;
  cursor: pointer;
}
.card:hover {
  opacity: 0.8;
  background: rgba(0, 0, 0, 0.2);
}
.container {
  width: 40vw;
  height: 75vh;
  position: relative;
  top: 120px;
  margin: 0 auto;
  border-radius: 20px;
  padding: 30px;
  background: aliceblue;
  opacity: 0.9;
}
img {
  width: 100%;
}
.image {
  width: 50%;
  float: left;
}
.waku01 {
  clear: both;
  margin: 0 auto;
  padding: 7px;
  width: 50%;
  border: 1px solid #ccc;
  background: #fff;
  box-shadow: 1px 1px 5px rgba(20, 20, 20, 0.2); /* ドロップシャドウ 【横位置 縦位置 ぼかし幅 色】の順に記述 */
}

.profile {
  width: 100%;
  height: 22vh;
  margin: 10px;
}
.profile-text {
  width: 50%;
  float: right;
}
h1.title {
  color: azure;
  position: absolute;
  top: 20px;
  left: 20px;
  margin: 0;
  cursor: pointer;
}
h2 {
  font-weight: 500;
  color: #00b09b;
  font-family: "Rounded Mplus 1c";
  margin: 20px;
  font-size: 30px;
}
button{
  border: #00b09b solid 2px;
  border-radius: 10px;
  background: azure;
  width: 120px;
  height:40px;
}
</style>