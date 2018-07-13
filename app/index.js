//========= アプリのセットアップ ==============

import express from 'express';
import GitHubController from './controllers/GitHubController';

const app = express();

app.use(express.static('public'));

app.set("views", 'public/views');
app.set("view engine", "ejs");


//============ routing ================

// リスト
app.get('/github/', (req, res) => {
	const gitHubController = new GitHubController();
	gitHubController.index(res, req);
});


// 詳細
app.get('/github/:id', (req, res) => {
	const gitHubController = new GitHubController();
	gitHubController.show(res, req);
})


//============== start ==================
app.listen(3000);