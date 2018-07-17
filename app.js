const Koa = require('koa');
const app = new Koa();
const logger = require('koa-logger')
app.use(logger());

app.use(async ctx => {
  ctx.body = 'Hello World';
});


app.listen(3000);

