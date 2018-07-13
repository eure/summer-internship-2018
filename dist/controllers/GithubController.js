'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

var _apiClient = require('../utils/apiClient.js');

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

var GitHubController = function () {
  function GitHubController() {
    _classCallCheck(this, GitHubController);
  }

  _createClass(GitHubController, [{
    key: 'index',
    value: function index(res, req) {
      _apiClient.githubClient.get('/trending').then(function (apiResponse) {
        console.log('======');
        console.log(apiResponse.data);
      });
      res.render('index', { title: "タイトル" });
    }
  }, {
    key: 'show',
    value: function show(res, req) {
      res.render('index', { title: "show画面 id:" + req.params.id });
    }
  }]);

  return GitHubController;
}();

exports.default = GitHubController;