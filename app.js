const Koa = require('koa');
const app = new Koa();
const logger = require('koa-logger');
const Pug = require('koa-pug');
const request = require("request");
const client = require('cheerio-httpcli');
const router = require('koa-router')();

app.use(logger());



app.use(router.routes());

// pugの設定
const pug = new Pug({
  viewPath: './views',
  basedir: './views',
  app: app,
});

// ポート番号
app.listen( process.env.PORT || 3000);

// アクセスした時の処理
router.get('/', async (ctx, next) => {
  // cherrio-httpcli を用いてgithubのトレンドページをスクレイピング
  let url = 'https://github.com/trending';
  let result = await client.fetch('https://github.com/trending');
  let $ = result.$;
  let $lists = $(".repo-list li");
  let lists = []
  // listsに各レポジトリの情報を格納する
  $lists.each((i,el)=>{
    let list_obj = {};
    list_obj.repo = $(el).find("h3").text().trim();
    list_obj.link = $(el).find("h3 a").attr("href");
    list_obj.description = $(el).find(".py-1").text().trim();
    list_obj.star = $(el).find("svg[aria-label='star']").parent().text().trim();
    list_obj.fork = $(el).find("svg[aria-label='fork']").parent().text().trim();
    lists.push(list_obj);
  });
  ctx.render('index', {lists: lists});
});

