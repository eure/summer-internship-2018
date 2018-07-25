<?php 
require_once("./phpQuery/phpQuery/phpQuery.php"); 
$html = file_get_contents("https://github.com/trending");
#echo phpQuery::newDocument($html)->find("h1")->text();
?>
<html>

<head>
<link rel="stylesheet"type="text/css"href="viewer.css"media="all">
<title>
GitHubTrend
</title>
</head>

<body>
<div id="sidebar">
<?php
#$$get_trend=str_replace(array(" "," "),"",phpQuery::newDocument($html)->find("h3")->find("a")->text());
$check=phpQuery::newDocument($html);
$num=count($check["h3"]);
?>
<li>
<a href="./show_detail.php">home</a>
</br></br>
</li>
<?php
for($i=0;$i<$num;$i++){
		$get_trend=pq($check)->find("h3")->find("a:eq(${i})")->text();
		$replace_trend=str_replace(" ","",$get_trend);		
#echo "<form name=\"detail\" method=\"post\" action=\"show_detail.php\" >";
#echo"<input type=\"hidden\" name=\"input_detail\" value=".$replace_trend.">";
echo"<li>";
#echo"<a href=\"javascript:detail.submit()\">".$get_trend."</a>";
echo"<a href=\"show_detail.php?link=".$replace_trend."\">".$get_trend."</a>";
echo"</li>";
#echo"</form>";
}
?>
</div>
</body>

</html>
