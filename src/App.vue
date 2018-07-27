<template>
  <div id="app">
     <input type="checkbox" class="check" id="checked">
    <label class="menu-btn" for="checked">
        <span class="bar top"></span>
        <span class="bar middle"></span>
        <span class="bar bottom"></span>
    </label>
    <label class="close-menu" for="checked"></label>
    <nav class="drawer-menu">
        <ul>
            <li><a @click="$router.push({path:`/`})">ユーザ検索</a></li>
            <li><a @click="$router.push({path:`/user/unotovive`})">マイページ</a></li>
        </ul>
    </nav>
    <div class="contents">
       <router-view/>
    </div>

  </div>
</template>

<script>
export default {
  name: 'App'
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin:0px;
  background: #aa4b6b;
}
/*menu from https://codepen.io/42EG4M1/pen/ByvGPa*/
/* common */

ul {
  margin: 0;
  padding: 0;
	list-style: none;
}

/* contents */
.contents {
    display: table;
    width: 100%;
    height: 100vh;
    padding: 0;
    margin: 0;
    background: #aa4b6b;
    box-shadow: 0 0 50px 0 rgba(0,0,0,.8);
    -webkit-transition-property: all;
    transition-property: all;
    -webkit-transition-delay: .3s;
    transition-delay: .3s;
    -webkit-transition-duration: .5s;
    transition-duration: .5s;
    position: absolute;
    top :0;
}

.contents__inner {
    display: table-cell;
    vertical-align: middle;
    text-align: center;
}

.contents__inner h1 {
    margin: 0;
    padding: 0;
    color: #fff;
    font-size: 40px;
    font-family: Futura, "Century Gothic", "helvetica neue", arial, sans-serif !important;
    font-style: italic;
}

.contents__inner p {
    margin-top: 20px;
    color: #fff;
    font-size: 20px;
}

.contents__inner p span {
    border-bottom: 1px solid #fff;
}

/* drawer menu */
.drawer-menu {
    box-sizing: border-box;
    position: fixed;
    top: 0;
    right: 0;
    width: 300px;
    height: 100%;
    padding: 120px 0;
    background: #222;
    -webkit-transition-property: all;
    transition-property: all;
    -webkit-transition-duration: .5s;
    transition-duration: .5s;
    -webkit-transition-delay: 0s;
    transition-delay: 0s;
    -webkit-transform-origin: right center;
    -ms-transform-origin: right center;
    transform-origin: right center;
    -webkit-transform: perspective(500px) rotateY(-90deg);
    transform: perspective(500px) rotateY(-90deg);
    opacity: 0;
    
}

.drawer-menu li {
    text-align: center;
}

.drawer-menu li a {
    display: block;
    height: 50px;
    line-height: 50px;
    font-size: 14px;
    color: #fff;
    -webkit-transition: all .8s;
    transition: all .8s;
}

.drawer-menu li a:hover {
    color: #1a1e24;
    background: #fff;
}

/* checkbox */
.check {
    display: none;
}

/* menu button - label tag */
.menu-btn {
    position: fixed;
    display: block;
    top: 30px;
    right: 40px;
    display: block;
    width: 40px;
    height: 40px;
    font-size: 10px;
    text-align: center;
    cursor: pointer;
    z-index: 3;
}

.bar {
    position: absolute;
    top: 0;
    left: 0;
    display: block;
    width: 40px;
    height: 3px;
    background: #fff;
    -webkit-transition: all .5s;
    transition: all .5s;
    -webkit-transform-origin: left top;
    -ms-transform-origin: left top;
    transform-origin: left top;
}

.bar.middle {
    top: 15px;
    opacity: 1;
}

.bar.bottom {
    top: 30px;
    -webkit-transform-origin: left bottom;
    -ms-transform-origin: left bottom;
    transform-origin: left bottom;
}



.menu-btn:hover .bar {
    background: #999;
}

.menu-btn:hover .menu-btn__text {
    color: #999;
}

.close-menu {
    position: fixed;
    top: 0;
    right: 300px;
    width: 100%;
    height: 100vh;
    background: rgba(0,0,0,0);
    cursor: url(http://theorthodoxworks.com/demo/images/cross.svg),auto;
    -webkit-transition-property: all;
    transition-property: all;
    -webkit-transition-duration: .3s;
    transition-duration: .3s;
    -webkit-transition-delay: 0s;
    transition-delay: 0s;
    visibility: hidden;
    opacity: 0;
}

/* checked */
.check:checked ~ .drawer-menu {
    -webkit-transition-delay: .3s;
    transition-delay: .3s;
    -webkit-transform: none;
    -ms-transform: none;
    transform: none;
    opacity: 1;
    z-index: 2;
}

.check:checked ~ .contents {
    -webkit-transition-delay: 0s;
    transition-delay: 0s;
    -webkit-transform: translateX(-300px);
    -ms-transform: translateX(-300px);
    transform: translateX(-300px);
}

.check:checked ~ .menu-btn .menu-btn__text {
    visibility: hidden;
    opacity: 0;
}

.check:checked ~ .menu-btn .bar.top {
    width: 56px;
    -webkit-transform: rotate(45deg);
    -ms-transform: rotate(45deg);
    transform: rotate(45deg);
}

.check:checked ~ .menu-btn .bar.middle {
    opacity: 0;
}

.check:checked ~ .menu-btn .bar.bottom {
    width: 56px;
    top: 40px;
    -webkit-transform: rotate(-45deg);
    -ms-transform: rotate(-45deg);
    transform: rotate(-45deg);
}

.check:checked ~ .close-menu {
    -webkit-transition-duration: 1s;
    transition-duration: 1s;
    -webkit-transition-delay: .3s;
    transition-delay: .3s;
    background: rgba(0,0,0,.5);
    visibility: visible;
    opacity: 1;
    z-index: 3;
}
</style>
