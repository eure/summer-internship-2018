<template>
    <div id="main" @click="$emit('set', repo)">
        <h2>{{repo.name}}</h2>
        <p><span v-if="this.repo.description==this.nul">no description</span>{{repo.description}}</p>
        <p>最終更新：{{repo.updated_at}}</p>
        <p>{{repo.language}}/☆{{repo.stargazers_count}}</p>
    </div>
</template>
<script>
export default {
    props:['repo'],
    data(){
        return{
            nul:null
        }
    }
}
</script>
<style scoped>
    #main{
        border-radius: 10px;
        border: 2px solid #373737;
        padding: 0;
    }
    h2{
        padding: 0;
        margin: 0;
    }
    p{
        padding-top:5px;;
        margin: 0;
        overflow: hidden;
        height: 1em ;
        font-size: 1em;
        line-height: 1;
    }
</style>
