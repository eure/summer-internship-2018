実装日記

https://github.com/sheharyarn/github-trending
があるのでこれをそのまま使ってしまおう（いいのかこれ）

トップ画面（何もなし）、取ってくるボタンを押すとスクレイパー起動、
リストには名前とスター、
:name, :lang, :description, :star_count, :url
でいける。

commit

newの位置にあるボタンを削除し、代わりにトレンド取ってくるボタン
get_trendアクションを作り、そこでトレンドを取ってきて登録する動作を

と思ったけどでかめの問題、githubのサイトが改修でもされたのか、
github-trendingがそのままだと機能しない
幸い普通に修正できそうなので、自分でforkして直すことにする

めっちゃかかったがgithub-trendingの修正がなんとかできた

commit

最低限動くのが目標だったのであとはチューニング。
専用のアクションを作ったが、indexで十分そうなので、indexにてリスト化をやらせる。

commit

descriptionとurlは冗長なので非表示にする

commit

取ってきたデータはデータベースに保存するようにして、
最近1日以内に取ってきたデータがあればそれを表示するようにする。

trendsetモデルを用意して、トレンド取得一回ごとにtrendset作成。
1対多でtrendを持つ。
indexへのアクセスの際は、日付が今日なtrend_setのうちidが一番大きいものが
存在したらそのtrendsetを、そうでなければ取得を、というルーチン。
trendにはtrendset_id列を足す必要あり
trendsetはidとcreated_atさえあればよい



予定メモ
（手動リフレッシュもできるようにする）
trend取得全成功を仮定しているがこれはあまりよくない
詳細表示画面の作成をする。
例外処理の追加
ピン留めとかができるとアツい


環境メモ
ec2-user:~/environment/summer-internship-2018 (master) $ ruby -v
ruby 2.4.1p111 (2017-03-22 revision 58053) [x86_64-linux]
ec2-user:~/environment/summer-internship-2018 (master) $ rails -v
Rails 5.2.0

gemfileに追記、bunlde update
gem 'github-trending', github: 'iwannatto/github-trending'


- 仕様説明
    - 実現した機能の簡単な解説
    - スクリーンショット
- 環境構築マニュアル
- 言語/ライブラリ/アーキテクチャなどの選定理由
- こだわりポイント