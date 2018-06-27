var express = require('express');
var router = express.Router();
var scrapingTrend = require("../scraping");

/* GET home page. */
router.get('/', function(req, res, next) {
  let target = "https://github.com/trending";
  scrapingTrend(target)
    .then( (items) => {
      res.render('index', {title: 'GitHub Trend', items: items});
    })
    .catch( (err) => {
      console.log(err);
    });
});

module.exports = router;
