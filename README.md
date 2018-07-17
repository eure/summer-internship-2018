# GitHubトレンド
## 仕様説明
### 実現した機能の簡単な解説
GitHubトレンドをリスト形式で表示できる。レポジトリ名をクリックするとREADME.mdファイルをレンダリングして表示する。
### スクリーンショット
![fireshot capture 88 - github trend - http___localhost_3000_](https://user-images.githubusercontent.com/27331655/42813306-6909e0f0-8975-11e8-872b-6cfe55e7639b.png)
![fireshot capture 89 - donnemartin_system-design-primer_ - http___localhost_3000_detail](https://user-images.githubusercontent.com/27331655/42813320-78357008-8975-11e8-8667-7403cdc5f850.png)

## 環境構築マニュアル
MacBookA ir(2016), node v8.11.1で動作を確認しています。
1. このリポジトリをクローンしてください。
```
$ git clone <このリポジトリ>
$ cd <このリポジトリ>
```
2. 以下のコマンドを打って必要なモジュールをインストールしてください。
```
$ npm install
```
3. 以下のコマンドを打ってサーバーを起動させてください。
```
$ npm start
```
4. [http://localhost:3000/](http://localhost:3000/) にアクセスしてください。

## 言語/ライブラリ/アーキテクチャなどの選定理由
### 言語
書き慣れた言語のため、node.jsを採用。

### テンプレートエンジン
入れ子を少なくできるpugを採用。

### フレームワーク
デファクトスタンダードで使い慣れているExpressを採用しても良かったが、Expressと同じ作者が作っている新しいフレームワークであるKoaを採用した。Koaはミドルウェアを自分で導入する必要がありよい練習になると思った。
### モジュール
- request-promise
- cheerio-httpcli
- showdown
- github-markdown-css
requestではpromiseが使えないため、request-promiseを採用した。

cheerio-httpcliはスクレイピングの際にjQueryのような感覚でコードを書くことができる。

showdownはmarkdownをhtml化するのに必要だった。

github-markdown-cssはnpm installせず、pubicフォルダに置いて利用した。

## こだわりポイント

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