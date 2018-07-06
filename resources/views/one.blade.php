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
  <div class="content">
    <div class="sitename">
      <a href="http://localhost:8000/">{{$site_name}}</a> > {{$data['title']}}
    </div>
    <div class="text">
      詳細<br>
      <div class="content-text">
        <?php
          if(!$data['description']) echo "内容が読み込めませんでした.続きを確認してください.";
          else echo $data['description'];
        ?>
      <!-- {{$data['description']}} -->
      </div>
      <div class="more">
        <a target="_blank" href="{{$data['link']}}">続きを読む</a>
      </div>
    </div>
    <div class="date">
      {{$data['date']}}
    </div>
  </div>
</div>
<div class="footer">
  - RSS Checker -
</div>
</body>
</html>