実装日記

https://github.com/sheharyarn/github-trending
があるのでこれをそのまま使ってしまおう（いいのかこれ）

gem でライブラリを取ってくる、bunlderのみこれ
Gemfile + bundle installでgemを入れる


トップ画面（何もなし）、取ってくるボタンを押すとスクレイパー起動、
リストには名前とスター、
:name, :lang, :description, :star_count, :url
でいける。

gemfileに追記、
bin/rails db:migrate RAILS_ENV=development
bunlde update

commit

newの位置にあるボタンを削除し、代わりにトレンド取ってくるボタン
get_trendアクションを作り、そこでトレンドを取ってきて登録する動作を

と思ったけどでかめの問題、githubのサイトが改修でもされたのか、
github-trendingがそのままだと機能しない
幸い普通に修正できそうなので、自分でforkして直すことにする

めっちゃかかったがgithub-trendingの修正がなんとかできた



環境メモ
ec2-user:~/environment/summer-internship-2018 (master) $ ruby -v
ruby 2.4.1p111 (2017-03-22 revision 58053) [x86_64-linux]
ec2-user:~/environment/summer-internship-2018 (master) $ rails -v
Rails 5.2.0


- 仕様説明
    - 実現した機能の簡単な解説
    - スクリーンショット
- 環境構築マニュアル
- 言語/ライブラリ/アーキテクチャなどの選定理由
- こだわりポイント