<?php
  require_once("./phpQuery-onefile.php");
  $html = file_get_contents("https://github.com/trending");
  $query = phpQuery::newDocument($html);
  $titles = $query->find("h3");
  foreach ($titles as $title) {
     $path = pq($title)->find('a')->attr('href');
      echo "<a href='repository.php?path=".urlencode($path)."'>".pq($title)->text()."</a><br>";
  }
?>