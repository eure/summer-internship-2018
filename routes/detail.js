var express = require('express');
var router = express.Router();


router.get('/detail/:user/:repo', function(req, res, next) {
    console.log(req.params.user);
});

module.exports = router;