<?php
     echo '<link rel=stylesheet href="scrap.css">';
    //phpQueruyの読み込み
    require_once("phpquery-onefile.php");
    //HTMLの取得
    $html = file_get_contents("https://github.com/trending");
    
    //DOM取得
    $doc = phpQuery::newDocument($html);

    //スクレイピング、配列に格納
    for ($i=0; $i<=24; $i++) {
        $title[] = $doc->find('h3:eq('.$i.')')->text();
   }
    //表示部
    echo '<center><h1>Trend List</h1>';
    echo '<ul style="display:inline-block">';
     
    foreach($title as $title_element){
        //空白排除
        $title_element = str_replace (array("　"," ","\t"),'',$title_element);
        echo '<li><a href ="https://github.com/'.$title_element.'">'.$title_element.'</a></li>';
    }
    echo '</ul></center>';
?>