<html>
<head>
<!-- CSS読み込み-->
<link rel="stylesheet"type="text/css"href="viewer.css"media="all">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-JP">
<?php
#現在表示しているコンテンツ名を表示
if($_GET['link']==""){
	$now_contents="home";
}
else{$now_contents=trim($_GET['link']);}
?>
</head>
<body>
	<div class="header">
		<!--よくあるタイトルバナーをクリックするとホーム画面に戻れる仕様 -->
		<span class="header"><a href="./GitHubTrend.php">Github Trend Viewer</a></span>

		</br>
		<font class="contents"><?php echo $now_contents; ?></font>
		</br></br></br>

	</div>
</body>
