<template>
  <div id="content">
    <h1 class="title"><i class="fab fa-github" /> Gitviewer</h1>
    <div class="container">
      <h2>ユーザーを表示</h2>
      <input placeholder="ex:unotovive" v-model="name">
      <button @click="goUserPage()"><span>表示 <i class="fas fa-arrow-right"/></span></button>
    </div>
  </div>
</template>

<script>
export default {
  name: 'HelloWorld',
  data () {
    return {
      name:''
    }
  },
  methods:{
    goUserPage(){
        this.$router.push({path:`/user/${this.name}`})
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
@import url('https://fonts.googleapis.com/css?family=Lato:900');
#content{
  font-family: 'Lato', sans-serif;
  position: absolute;
  top :0;
  background: #aa4b6b;
  background: -webkit-linear-gradient(to right, #00b09b,#96c93d);
  background: linear-gradient(to right, #00b09b,#96c93d);
  width: 100vw;
  height: 100vh
}
.container{
  position: absolute;
  top:33%;
  right: 0;
  left: 0;
}
h1.title{
  color: azure;
  position: absolute;
  top: 20px;
  left: 20px;;
  margin: 0;
}
h2{
  font-weight: 400;
  color: azure;
  font-family: "Rounded Mplus 1c";
  margin: 25px;
  font-size: 30px;
}
input {
  -webkit-appearance: none;
     -moz-appearance: none;
          appearance: none;
  outline: 0;
  border: 1px solid rgba(255, 255, 255, 0.4);
  background-color: rgba(255, 255, 255, 0.2);
  width: 250px;
  border-radius: 3px;
  padding: 10px 15px;
  margin: 10px auto 10px auto;
  display: block;
  text-align: center;
  font-size: 18px;
  color: white;
  transition-duration: 0.25s;
  font-weight: 300;
}
input:hover {
  background-color: rgba(255, 255, 255, 0.4);
}
input:focus {
  background-color: white;
  width: 300px;
  color: #00b09b;
}
input::-webkit-input-placeholder {
    color: azure;
    opacity: 0.9;
}
input:-ms-input-placeholder {
    color: azure;
    opacity: 0.9;
}
input::-moz-placeholder {
    color: azure;
    opacity: 0.9;
}
input::-placeholder {
    color:azure;
    opacity: 0.9;
}
button {
  background-color: transparent;
  border: 2px solid #fff;
  color: #fff;
  line-height: 50px;
  width: 200px;
  font-size: 16px;
  font-weight: 200;
  border-radius: 5px;
  height: 50px;
  margin: 25px;
}
button span{
  position: relative;
  left :7px;
}

button:hover {
  background-color: rgba(255, 255, 255, .2);
}
</style>
