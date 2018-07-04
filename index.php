<?php
  require_once("./phpQuery-onefile.php");
  $html = file_get_contents("https://github.com/trending");
  $query = phpQuery::newDocument($html);
  $titles = $query->find("h3");
  foreach ($titles as $title) {
      echo "<a href='repository.php'>".pq($title)->text()."</a><br>";
  }
?>