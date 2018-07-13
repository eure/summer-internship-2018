// アプリのセットアップ
import express from 'express';

const app = express();

app.use(express.static('public'));

app.set("views", 'public/views');
app.set("view engine", "ejs");

// routing
app.get('/', (req, res) => {
	console.log('hoge');
	// res.send('Hello Worldd');
	res.render('index', {title: "タイトル"});
});

app.listen(3000);