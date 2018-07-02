var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

var indexRouter = require('./routes/index');

var scraping = require('./scraping');
// なぜか動かない
// var detailRouter = require('./routes/detail');

var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());

// 静的ファイルのパスを指定
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', indexRouter);
app.get('/detail/:user/:repo', (req, res, next) => {
  let user = req.params.user;
  let repository = req.params.repo;
  scraping.crawlingMarkDown(user, repository)
    .then( (readme) => {
      res.render('detail', { "readme":readme });
    })
    .catch( (err) => {
      console.log(err)
      res.render('error', {"message": res.status(), "error":err } );
    });
});

// なぜか動かない
// app.use('/detail/:user/:repo', detailRouter);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
