var express = require('express');
var router = express.Router();

var path = require('path');

/* GET home page. */
router.get('/', function(req, res, next) {
  res.sendFile(path.resolve('public/index.html'));
});

router.get('/repos', function(req, res, next) {
  res.sendFile(path.resolve('public/index.html'));
});

router.get('/repos/detail', function(req, res, next) {
  res.sendFile(path.resolve('public/index.html'));
});

module.exports = router;
