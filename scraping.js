var request = require("request");
var cheerio = require("cheerio");

var Repository = require('./models/Repository');

var target = "https://github.com/trending";

scrapingTrend = (url) => {
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
                    let lang = $(elem).find('span [itemprop="programmingLanguage"]').text().trim();
                    if (lang == "") {
                        lang = "none";
                    } 
                    let todaysStar = $(elem).find('span.d-inline-block.float-sm-right').text().trim();
                    let repo = new Repository(link[1], link[2], lang, todaysStar);
                    console.log(repo);
                    // console.log(link + " " + lang + " " + todaysStar);
                });
                // callBack()
            } catch (e) {
                console.error(e);
            }
        }
    });
}

scrapingTrend(target);

module.exports = scrapingTrend;

