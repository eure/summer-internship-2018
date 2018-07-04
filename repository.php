<?php
  require_once("./phpQuery-onefile.php");
  $html = file_get_contents("https://github.com".urldecode($_GET['path']));
  $query = phpQuery::newDocument($html);
  $title = $query->find("h1")->text();
  $readme = $query->find("#readme");
  
?>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title></title>
<meta charset="utf-8">
<meta name="description" content="">
<meta name="author" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!--[if lt IE 9]>
<script src="//cdn.jsdelivr.net/html5shiv/3.7.2/html5shiv.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
<link rel="shortcut icon" href="">
</head>
<body>
    <div class="main">
        <div id="header">
            <h1><?=$title?></h1>
        </div>
        <?= $readme?>
    </div>
    
</body>
</html>