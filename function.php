<?php

// 指定したURLのRSSフィードを配列で取得する

function getRssFeedArray($url, $nKiji){

	// (引数：RSSフィードURL, 取得したい記事数）

	// 取得して準備
	$xml = simplexml_load_file($url);

	if($xml){ // 準備できたら

		$i = 0; // カウンタ
		foreach($xml->channel->item as $item){
。

			// 記事タイトル
			$a[$i]['title'] = htmlspecialchars((string)$item->title, ENT_QUOTES, "UTF-8");

			// 記事URL
			$a[$i]['link']  = htmlspecialchars((string)$item->link, ENT_QUOTES, "UTF-8");

			// 公開日時
			$time = strtotime($item->pubDate);
			$a[$i]['time'] = getTime_j(htmlspecialchars((string)$time, ENT_QUOTES, "UTF-8"));

			// 記事説明
			$a[$i]['description'] = htmlspecialchars((string)$item->description, ENT_QUOTES, "UTF-8");

			// 記事の中で最初に使われている画像を検索、設定する
			if( preg_match_all('/<img([\s\S]+?)>/is', $item->description, $matches) ){
				foreach( $matches[0] as $img ){
					if( preg_match('/src=[\'"](.+?jpe?g)[\'"]/', $img, $m) ){
						$item->thumbnail = $m[1];
						$a[$i]['image'] = htmlspecialchars((string)$item->thumbnail, ENT_QUOTES, "UTF-8");
					}
				}
			}

            $i++;

			// 取得するのは$nKiji分だけ
			if($i == $nKiji){
				break;
			}

		}

	}else{
		// エラーです。
    }

    // お疲れ様でした
	return $a;

}

// time値から日本語値を得る。
function getTime_j($time){

	$weeks = array('日','月','火','水','木','金','土');

	$time_j = date('Y/m/d',$time).'（'.$weeks[date('w',$time)].'）'.date('H：i：s',$time);

	return $time_j;

}

?>