var express = require('express');
var router = express.Router();

/* GET users listing. */
router.get('/g', function(req, res, next) {
  console.log(req.url);
  res.send('respond with a resource');
});

module.exports = router;
