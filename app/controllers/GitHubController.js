import cheerio from 'cheerio';
import { githubClient } from '../utils/apiClient.js';

export default class GitHubController {

  index(res, req) {
  	let query;
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

	githubClient.get('/trending' + query).then(apiResponse => {

		const $ = cheerio.load(apiResponse.data);
	    const repositories = [];

	    $('li', 'ol.repo-list').each((index, repo) => {
	      const title = $(repo).find('h3').text().trim();

	      const starLink = '/' + title.replace(/ /g, '') + '/stargazers';

	      repositories.push({
	        author: title.split(' / ')[0],
	        name: title.split(' / ')[1],
	        path: title.replace(/ /g, ''),
	        description: $(repo).find('p', '.py-1').text().trim() || null,
	        language: $(repo).find('[itemprop=programmingLanguage]').text().trim(),
	        stars: parseInt($(repo).find('[href="' + starLink + '"]').text().trim().replace(',', '') || 0)
	      });
	    });

	    res.render('index', {title: "タイトル", repositories: repositories});

	}).catch(err => {
		console.log(err);
	});
  }

  show(res, req) {
  	res.render('index', {title: "show画面 id:" + req.params.id})
  }

}