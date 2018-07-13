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
		value: function index(res, req) {
			_apiClient.githubClient.get('/trending').then(function (apiResponse) {

				var $ = _cheerio2.default.load(apiResponse.data);
				var repositories = [];

				$('li', 'ol.repo-list').each(function (index, repo) {
					var title = $(repo).find('h3').text().trim();

					var starLink = '/' + title.replace(/ /g, '') + '/stargazers';

					repositories.push({
						author: title.split(' / ')[0],
						name: title.split(' / ')[1],
						href: 'https://github.com/' + title.replace(/ /g, ''),
						description: $(repo).find('p', '.py-1').text().trim() || null,
						language: $(repo).find('[itemprop=programmingLanguage]').text().trim(),
						stars: parseInt($(repo).find('[href="' + starLink + '"]').text().trim().replace(',', '') || 0)
					});
				});

				res.render('index', { title: "タイトル", repositories: repositories });
			}).catch(function (err) {
				console.log(err);
			});
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