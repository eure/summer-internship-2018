import cheerio from 'cheerio';
import { githubClient } from '../utils/apiClient.js';

export default class GitHubController {

  // 一覧画面
  index(res, req) {

  	// クエリの解析をする
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

  	// GitHubのトレンド一覧ページをスクレイピング・解析する
	githubClient.get('/trending' + query).then(apiResponse => {

	  // HTMLをパースする
	  const $ = cheerio.load(apiResponse.data);
      const repositories = [];

      // 情報取得
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

	  // ページを描画
	  res.render('index', {title: "タイトル", repositories: repositories});

	}).catch(err => {

	  console.log(err);

	  res.render('500', { message: "GitHubの情報を取得できませんでした" });

	});
  }

  // 詳細画面
  show(res, req) {

  	// Githubのリポジトリ詳細ページを解析、情報取得
  	githubClient.get(`/${req.params.author}/${req.params.title}`).then(apiResponse => {

  	  // HTMLをパース
  	  const $ = cheerio.load(apiResponse.data);
  	  const languages = [];

  	  // 情報を取得
  	  $('li', 'ol.repository-lang-stats-numbers').each((index, lang) => {

  	  	let lang_data = {};

  	  	if(lang.children.find(child => child.type === 'tag')) {

  	  	  // 使用言語
	   	  lang_data.language =
	   	  	lang.children.find(child => child.type === 'tag').children.find( child => child.attribs && child.attribs.class === 'lang').children[0].data;

	   	  // 使用比率
	   	  lang_data.percent =
	   	  	lang.children.find(child => child.type === 'tag').children.find( child => child.attribs && child.attribs.class === 'percent').children[0].data
	   	  	.match(/(.+)%/)[1];

	   	  // color
	   	  lang_data.color =
	   	  	lang.children.find(child => child.type === 'tag').children.find( child => child.attribs && child.attribs.class === 'color-block language-color').attribs.style
	   	  	.match(/background-color:(.+);/)[1];

	   	}

	   	languages.push(lang_data);

  	  });

  	  // 画面を描画
  	  res.render('show', {title: req.params.title, author: req.params.author, languages: languages});

  	}).catch(err => {

  		console.log(err);

  		res.render('500', 'GitHubの情報を取得できませんでした。');

  	});

  }

}