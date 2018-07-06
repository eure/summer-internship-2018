<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>RSS Checker</title>
<meta name="viewport" content="width=device-width,initial-scale=1">
<meta name="format-detection" content="telephone=no">
<meta name="viewport" content="width=device-width,user-scalable=0">
<link rel="stylesheet" href="/css/reset.css">
<link rel="stylesheet" href="/css/style.css">
</head>
<body>
<div class="main">
  <div class="title">
    RSS Checker
  </div>
  <div class="textfield">
    <form method="post" action="http://localhost:8000/urlupdate">
      <input placeholder="RSS or RDF" type="text" class="input" name="url">
    </form>
  </div>
  <div>
    <div class="sitename">
      {{$site_name}} >
    </div>
    <?php
      if($data){
        $i=0;
        foreach($data as $one){
          echo "<div class='line'><div class='link'><a href='http://localhost:8000/data/";
          echo $i;
          echo "'>";
          echo mb_strimwidth($one['title'], 0, 40, "...", 'UTF-8');
          echo "</a></div><div class='name'>";
          echo $site_name;
          echo "</div></div>";
          $i++;
        }
      }
    ?>
  </div>
</div>
<div class="footer">
  - RSS Checker -
</div>
</body>
</html>