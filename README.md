# summer-internship-2018 サーバーサイド課題

## 仕様説明

### 実現した機能の簡単な解説

- GitHubのtrendingページ（ https://github.com/trending ）をリスト形式に表示。
- trendingを日ごと・週ごと・月ごとにソートする機能。
- 詳細ページでレポジトリの使用言語の比率を円グラフで描画。

### スクリーンショット

- 一覧ページ
[![Image from Gyazo](https://i.gyazo.com/26a155ca5c1ff222ccaae3b4c0e61854.png)](https://gyazo.com/26a155ca5c1ff222ccaae3b4c0e61854)

- 詳細ページ
[![Image from Gyazo](https://i.gyazo.com/8087377da09dd159a135c1dd3fb8dde3.png)](https://gyazo.com/8087377da09dd159a135c1dd3fb8dde3)


### 環境構築マニュアル

### 言語/ライブラリ/アーキテクチャなどの選定理由

- Node.js / Express.js

```
サーバーサイドを高速で開発するため。
```

- Axios.js

```
GitHubのページを取得・レスポンスを取得するため。簡単に扱えるライブラリであるからaxiosを使用した。
```

- cheerio.js

```
スクレイピングするため。ドキュメントが読みやすかったため、使用。
```

- Chart.js

```
円グラフを描画するため。ドキュメントが豊富だったため、使用。
```

### こだわりポイント

```
使用言語の比率を円グラフで描画していること。GitHubでは使用言語を数字で表示しているだけなので円グラフにすることでより使用言語を視覚的にわかりやすくしました。
```
