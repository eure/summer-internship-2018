// モジュールの読み込み
const Koa = require('koa');
const app = new Koa();
const logger = require('koa-logger');
const router = require('koa-router')();
const Pug = require('koa-pug');
const serve = require('koa-static');
const rp = require("request-promise");
const client = require('cheerio-httpcli');
const showdown  = require('showdown');



app.use(logger());
app.use(serve('./public'));
app.use(router.routes());

// pugの設定
const pug = new Pug({
  viewPath: './views',
  basedir: './views',
  app: app,
});

// ポート番号
app.listen(3000);

// トップページにアクセスした時の処理
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

// markdown to html converter
const converter = new showdown.Converter();

// 各詳細ページにアクセスした時の処理
router.get('/detail', async (ctx, next) => {
  // エスケープ
  let repo = decodeURIComponent(ctx.query.repo);
  let md = await rp.get("https://raw.githubusercontent.com/"+repo+"/master/README.md");
  let md_html = converter.makeHtml(md); // convert md to html
  ctx.render('detail', {md_html: md_html, repo:repo});
});

