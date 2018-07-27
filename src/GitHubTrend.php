<html>
<!-- コンテンツを表示するページ-->
<head>
<?php
#phpQuery読み込み
require_once("../phpQuery/phpQuery/phpQuery.php");
?>
<!-- CSSの読み込み-->
<link rel="stylesheet"type="text/css"href="viewer.css"media="all">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-JP">
<?php
#詳細を表示するコンテンツをGETで受け取る
#引数なしの場合はホームのページを表示
$input_detail=trim(htmlspecialchars($_GET["link"]));
if($input_detail==""){
		$domain="./home.php";
}
else{
$domain="https://www.github.com/".$input_detail."/blob/master/README.md";
}

?>
<title>
GitHubTrend
</title>
</head>

<body>
<?php 
#header読み込み
include('header.php');
#sidebar読み込み
include('sidebar.php');
echo "<div id=\"contents\">";
#表示するコンテンツのドメイン取得
$html = file_get_contents($domain);
echo "<div id=\"main\">";
#表示内容は情報量を抑えるためreadmeのみとする
echo phpQuery::newDocument($html)->find("#readme");
echo"</div>";
echo"</div>";
?>
</body>

</html>
