# 仕様説明
## 実現した機能の簡単な解説
GitHubトレンドをリスト形式で表示できる。レポジトリ名をクリックするとREADME.mdファイルをレンダリングして表示する。

# 環境構築マニュアル
MacBookA ir(2016), node v8.11.1で動作を確認しています。
1. このリポジトリをクローンしてください。
```
$ git clone <このリポジトリ>
$ cd <このリポジトリ>
```
1. 以下のコマンドを打って必要なモジュールをインストールしてください。
```
$ npm install
```
1. 以下のコマンドを打ってサーバーを起動させてください。
```
$ npm start
```
1. [http://localhost:3000/](http://localhost:3000/) にアクセスしてください。

# 言語/ライブラリ/アーキテクチャなどの選定理由
## 言語
書き慣れた言語のため、node.jsを採用。

## テンプレートエンジン
入れ子を少なくできる

## フレームワーク
デファクトスタンダードで使い慣れているExpressを採用しても良かったが、Expressと同じ作者が作っている新しいフレームワークであるKoaを採用した。Koaはミドルウェアを自分で導入する必要がありよい練習になると思った。
## モジュール
- request-promise
- cheerio-httpcli
- showdown
- github-markdown-css
requestではpromiseが使えないため、request-promiseを採用した。

cheerio-httpcliはスクレイピングの際にjQueryのような感覚でコードを書くことができる。

showdownはmarkdownをhtml化するのに必要だった。

github-markdown-cssはnpm installせず、pubicフォルダに置いて利用した。

# こだわりポイント

- async/awaitをできる限り用いて、コールバックの入れ子を減らしている。
-- モジュールもPromiseが使えるものを選んでいる。（request-promiseなど）
- pugファイルのコードの量が少ない。
-- GitHubトレンドのwebページから必要な情報のみをJSON形式にまとめ、pugに変数として渡している。
-- README.mdをHTMLに変換し、pugに変数として渡している。
-- headerをincludeして読み込んでいる。
- 一般論ではあるが、JavaScriptは他の動的プログラミング言語に比べて速い。
- クエリパラメータによって詳細ページの表示を制御している。GitHubトレンドに載っていないレポジトリでもパラメータをいじればREADME.mdを表示可能。
- GitHub Markdownと同じデザイン。
- データベース不要。