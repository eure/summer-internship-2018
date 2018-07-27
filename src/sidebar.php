
<html>

<head>
<!-- CSSの読み込み-->
<link rel="stylesheet"type="text/css"href="viewer.css"media="all">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-JP">
<?php 
#phpQuerynの読み込み
require_once("../phpQuery/phpQuery/phpQuery.php"); 
?>
</head>

<body>
<div id="sidebar">
<?php
#GitHubTrendページをスクレイピング
$html=file_get_contents("https://github.com/trending");
$check=phpQuery::newDocument($html);
?>
<!-- homeリンクはこのwebアプリケーションの概要を表示-->
<li>
<a href="./GitHubTrend.php">home</a>
</br></br>
</li>
<?php
#取得したGitHubTrendページからトレンドのリストを順に取得して表示
for($i=0;$i<count($check["h3"]);$i++){
		$get_trend=pq($check)->find("h3")->find("a:eq(${i})")->text();
		$replace_trend=str_replace(" ","",$get_trend);		
echo"<li>";
echo"<a href=\"GitHubTrend.php?link=".$replace_trend."\">".$get_trend."</a>";
echo"</li>";
}
?>
</div>
</body>

</html>
