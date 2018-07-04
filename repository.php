<?php
  require_once("./phpQuery-onefile.php");
  $html = file_get_contents("https://github.com".urldecode($_GET['path']));
  $query = phpQuery::newDocument($html);
  echo $query->find("h1")->text();
  
?>