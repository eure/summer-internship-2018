const Koa = require('koa');
const app = new Koa();
const logger = require('koa-logger')
const Pug = require('koa-pug')
app.use(logger());

const router = require('koa-router')();

app.use(router.routes());

router.get('/', async (ctx, next) => {
  ctx.render('index');
});


const pug = new Pug({
  viewPath: './views',
  basedir: './views',
  app: app // equals to pug.use(app) and app.use(pug.middleware)
});


app.listen( process.env.PORT || 3000);
