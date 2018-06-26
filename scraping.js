var request = require("request");
var cheerio = require("cheerio");

var Repository = require('./models/Repository');

scrapingTrend = (url) => {
    // スクレイピングした後にレンダリングしたいので, 
    return new Promise( (resolve, reject) => {
        items = [];
        request(url, (err, response, body) => {
            if (err) {
                // console.error(err);
                reject(err);
            } else {
                try {
                    const $ = cheerio.load(body);
                    const $repositorys = $('.col-12.d-block.width-full.py-4.border-bottom');
                    $repositorys.each( (idx, elem) => {
                        let link = $(elem).find('a').attr('href').split("/");
                        let lang = $(elem).find('span [itemprop="programmingLanguage"]').text().trim();
                        if (lang == "") {
                            lang = "none";
                        } 
                        let todaysStar = $(elem).find('span.d-inline-block.float-sm-right').text().trim();
                        let repo = new Repository(link[1], link[2], lang, todaysStar);
                        console.log(repo);
                        items.push(repo);
                        // console.log(link + " " + lang + " " + todaysStar);
                    });
                    resolve(items);
                } catch (e) {
                    // console.error(e);
                    reject(e);
                }
            }
        });
    })
}
// debug
scrapingTrend("https://github.com/trending");

module.exports = scrapingTrend;

