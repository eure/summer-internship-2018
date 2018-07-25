<html>

<head>
<link rel="stylesheet"type="text/css"href="viewer.css"media="all">
<?php
$input_detail=trim(htmlspecialchars($_GET["link"]));
if($input_detail==""||$input_detail=="home"){
		$domain="./home.php";
}
else{
$domain="https://www.github.com/".$input_detail."/blob/master/README.md";
}
?>
<title>
show_detail
</title>
</head>

<body>
<?php require_once("./phpQuery/phpQuery/phpQuery.php");
include('header.php');
include('GitHubTrend.php');
echo "<div id=\"contents\">";
$html = file_get_contents($domain);
echo "<div id=\"main\">";
echo phpQuery::newDocument($html)->find("#readme");
echo"</div>";
echo"</div>";
?>
</body>

</html>
