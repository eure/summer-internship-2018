import { githubClient } from '../utils/apiClient.js';

export default class GitHubController {

  index(res, req) {
	githubClient.get('/trending').then(apiResponse => {
		console.log('======');
		console.log(apiResponse.data);
	});
	res.render('index', {title: "タイトル"});
  }

  show(res, req) {
  	res.render('index', {title: "show画面 id:" + req.params.id})
  }

}