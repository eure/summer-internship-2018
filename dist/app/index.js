'use strict';

var _express = require('express');

var _express2 = _interopRequireDefault(_express);

var _GitHubController = require('./controllers/GitHubController');

var _GitHubController2 = _interopRequireDefault(_GitHubController);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

//========= アプリのセットアップ ==============

var app = (0, _express2.default)();

app.use(_express2.default.static('public'));

app.set("views", 'public/views');
app.set("view engine", "ejs");

//============ routing ================

// リスト
app.get('/github/', function (req, res) {
	var gitHubController = new _GitHubController2.default();
	gitHubController.index(res, req);
});

// 詳細
app.get('/github/:author/:title', function (req, res) {
	var gitHubController = new _GitHubController2.default();
	gitHubController.show(res, req);
});

//============== start ==================
app.listen(3000);