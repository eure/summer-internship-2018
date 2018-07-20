<?php
  require_once("./phpQuery-onefile.php");
  $html = file_get_contents("https://github.com/trending");
  $scraping_query = phpQuery::newDocument($html);
  $repositories = $scraping_query->find("h3");
  
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
<link rel="stylesheet" href="index.css">
<!--[if lt IE 9]>
<script src="//cdn.jsdelivr.net/html5shiv/3.7.2/html5shiv.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
<link rel="shortcut icon" href="">
</head>
<body>
    <div class="main">
        <div id="header">
            <h1>github trend</h1>
        </div>
        <div class="repo_list">
            <ul>
                <?php foreach ($repositories as $repository): ?>
                    <?php $detail_path = pq($repository)->find('a')->attr('href');?>
                    <li><a href='repository.php?path=<?=urlencode($detail_path)?>'><?=pq($repository)->text()?></a></li>
                <?php endforeach; ?>
            </ul>
            
        </div>
    </div>
    
</body>
</html>