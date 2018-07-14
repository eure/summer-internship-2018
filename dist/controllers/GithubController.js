'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

var _cheerio = require('cheerio');

var _cheerio2 = _interopRequireDefault(_cheerio);

var _apiClient = require('../utils/apiClient.js');

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

var GitHubController = function () {
  function GitHubController() {
    _classCallCheck(this, GitHubController);
  }

  _createClass(GitHubController, [{
    key: 'index',


    // 一覧画面
    value: function index(res, req) {

      // クエリの解析をする
      var query = void 0;
      switch (req.query.sort) {

        case "today":
          query = "?since=daily";
          break;

        case "week":
          query = "?since=weekly";
          break;

        case "month":
          query = "?since=monthly";
          break;

        case void 0:
          query = "";
          break;

      }

      // GitHubのトレンド一覧ページをスクレイピング・解析する
      _apiClient.githubClient.get('/trending' + query).then(function (apiResponse) {

        // HTMLをパースする
        var $ = _cheerio2.default.load(apiResponse.data);
        var repositories = [];

        // 情報取得
        $('li', 'ol.repo-list').each(function (index, repo) {
          var title = $(repo).find('h3').text().trim();

          var starLink = '/' + title.replace(/ /g, '') + '/stargazers';

          repositories.push({
            author: title.split(' / ')[0],
            name: title.split(' / ')[1],
            path: title.replace(/ /g, ''),
            description: $(repo).find('p', '.py-1').text().trim() || null,
            language: $(repo).find('[itemprop=programmingLanguage]').text().trim(),
            stars: parseInt($(repo).find('[href="' + starLink + '"]').text().trim().replace(',', '') || 0)
          });
        });

        // ページを描画
        res.render('index', { title: "タイトル", repositories: repositories });
      }).catch(function (err) {
        console.log(err);
      });
    }

    // 詳細画面

  }, {
    key: 'show',
    value: function show(res, req) {

      // Githubのリポジトリ詳細ページを解析、情報取得
      _apiClient.githubClient.get('/' + req.params.author + '/' + req.params.title).then(function (apiResponse) {

        // HTMLをパース
        var $ = _cheerio2.default.load(apiResponse.data);
        var languages = [];

        // 情報を取得
        $('li', 'ol.repository-lang-stats-numbers').each(function (index, lang) {

          var lang_data = {};

          if (lang.children.find(function (child) {
            return child.type === 'tag';
          })) {

            // 使用言語
            lang_data.language = lang.children.find(function (child) {
              return child.type === 'tag';
            }).children.find(function (child) {
              return child.attribs && child.attribs.class === 'lang';
            }).children[0].data;

            // 使用比率
            lang_data.percent = lang.children.find(function (child) {
              return child.type === 'tag';
            }).children.find(function (child) {
              return child.attribs && child.attribs.class === 'percent';
            }).children[0].data.match(/(.+)%/)[1];

            // color
            lang_data.color = lang.children.find(function (child) {
              return child.type === 'tag';
            }).children.find(function (child) {
              return child.attribs && child.attribs.class === 'color-block language-color';
            }).attribs.style.match(/background-color:(.+);/)[1];
          }

          languages.push(lang_data);
        });

        // 画面を描画
        res.render('show', { title: req.params.title, author: req.params.author, languages: languages });
      });
    }
  }]);

  return GitHubController;
}();

exports.default = GitHubController;