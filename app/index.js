//========= アプリのセットアップ ==============

import express from 'express';
import GitHubController from './controllers/GitHubController';

const app = express();
const router = express.Router();

app.use(express.static('public'));

app.set("views", 'public/views');
app.set("view engine", "ejs");


//============ routing ================

// トップページ
app.get('/', (req, res) => {
  res.redirect('/github');
})

// リスト
app.get('/github/', (req, res) => {
  const gitHubController = new GitHubController();
  gitHubController.index(res, req);
});

// 詳細
app.get('/github/:author/:title', (req, res) => {
  const gitHubController = new GitHubController();
  gitHubController.show(res, req);
});

// 404エラー
app.use(function(req, res, next){
  res.status(404);
  res.render('404', { message: req.path + ' is not exist.'});
});

// 500エラー
app.use(function(err, req, res, next){
  res.status(500);
  res.render('500', { message: ""})
});


//============== start ==================
app.listen(3000);
