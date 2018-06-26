var request = require("request");
var cheerio = require("cheerio");

var Repository = require('./models/repository');

var url = "https://github.com/trending"

scrapingTrend = (item, callBack) => {
    items = [];
    request(url, (err, response, body) => {
        if (err) {
            console.error(err);
        } else {
            try {
                const $ = cheerio.load(body);
                const $repositorys = $('.col-12.d-block.width-full.py-4.border-bottom');
                $repositorys.each( (idx, elem) => {
                    let link = $(elem).find('a').attr('href').split("/");
                    let lang = $(elem).find('span meta[itemprop="programmingLanguage"]').text();
                    if (lang == null) {
                        lang = "none";
                    } 
                    let todaysStar = $(elem).find('span.d-inline-block.float-sm-right').text().trim();
                    let repo = new Repository(link[1], link[2], lang, todaysStar);
                    items.push(repo);
                    console.log(repo);
                });
                callBack()
            } catch (e) {
                console.error(e);
            }
        }
    });
}

module.exports = scrapingTrend;

