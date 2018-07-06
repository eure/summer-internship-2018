<?php

	// ライブラリロード
require_once('./function.php');

$rss_url = 'http://ta9t.hatenablog.com/rss';

	// 最新5記事の情報を取得
$feedArray = getRssFeedArray($rss_url, 5);

	// echo "<pre>";
	// var_dump($feedArray);
	// echo "</pre>";
?>

<!DOCTYPE html>
<html lang="ja">
<head>
	<meta charset="utf-8">
	<title>Dairy Nap Diary RSS取得</title>
	<link rel="stylesheet" type="text/css" href="assets/css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="assets/css/style.css">
</head>
<body style="margin-top: 60px; background: #E4E6EB;">
	<div class="navbar navbar-default navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-collapse1" aria-expanded="false">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#">Daily Nap Diary</a>
			</div>
			<div class="collapse navbar-collapse" id="navbar-collapse1">
				<ul class="nav navbar-nav">
					<li class="active"><a href="#">記事一覧</a></li>
				</ul>
			</div>
		</div>
	</div>
	<?php foreach($feedArray as $row){ ?>
	<div class="col-md-12 rss_content">
		<div class="col-md-4">
			<img class="rss_image" src="<?php print $row['image']; ?>" alt="<?php print $row['title']; ?>" width="200">
			<br>
		</div>
		<div class="col-md-8">
			<a class="rss_title" href="<?php print $row['link']; ?>" target="_blank"><?php print $row['title']; ?></a>
			<br>
			<p><?php print $row['time']; ?></p>
			<?php  
			$description = mb_strimwidth($row["description"], 0, 400, "...", "UTF-8");
			?>
			<p><?php print $description; ?></p>
			<a href="<?php print $row['link']; ?>"><button type="button" class="btn btn-info link_button">続きを読む</button></a>
			<br>
		</div>
	</div>
	<?php } ?>


	<script src="assets/js/jquery-3.1.1.js"></script>
	<script src="assets/js/jquery-migrate-1.4.1.js"></script>
	<script src="assets/js/bootstrap.js"></script>
</body>
</html>