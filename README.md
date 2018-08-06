# summer-internship-2018(サーバーサイド 課題1)


## 仕様説明
github trendのページから情報をgolangでクロールしてきて、reactで描画します。
全体とは別に、いくつかの言語別のトレンドも表示できるようにしました。

![](https://raw.githubusercontent.com/hukuda222/summer-internship-2018/server-task1/img/image.png)


## 環境構築マニュアル
```bash
go get -u github.com/PuerkitoBio/goquery
go get -u github.com/jteeuwen/go-bindata/...
go get -u github.com/elazarl/go-bindata-assetfs/...
go get -u github.com/gin-gonic/gin
go get -u github.com/gin-gonic/contrib/static
go get -u github.com/pilu/fresh
go get -u gopkg.in/olebedev/go-duktape.v2

npm install

npm run bindata

npm run dev & fresh
```

http://localhost:3000/を開くと見られます。


## 言語/ライブラリ/アーキテクチャなどの選定理由
最近流行っているのでサーバーサイドをGolangで、クライアントサイドかなり使われてる割に僕自身は使ったことのなかったのでreact.jsで実装しました。

## こだわりポイント
特にないです。

