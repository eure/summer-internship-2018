'use strict';

var _express = require('express');

var _express2 = _interopRequireDefault(_express);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var app = (0, _express2.default)(); // アプリのセットアップ


app.use(_express2.default.static('public'));

app.set("views", 'public/views');
app.set("view engine", "ejs");

// routing
app.get('/', function (req, res) {
	console.log('hoge');
	// res.send('Hello Worldd');
	res.render('index', { title: "タイトル" });
});

app.listen(3000);