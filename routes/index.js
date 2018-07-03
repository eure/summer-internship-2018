var express = require('express');
var router = express.Router();

var scraping = require("../scraping");

/* GET home page. */
router.get('/', function(req, res, next) {
  console.log(req.url);
  let target = "https://github.com/trending";
  
  scraping.scrapingTrend(target)
    .then( (items) => {
      res.render('index', {title: 'GitHub Trend', items: items});
    })
    .catch( (err) => {
      console.log(err);
    });
});


module.exports = router;
