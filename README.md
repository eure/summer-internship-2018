# summer-internship-2018

エウレカサマーインターン2018の技術課題提出用リポジトリです。

## 課題1
1. [GitHubトレンド](https://github.com/trending)をリスト形式で表示できるサイトを作成してください
2. リスト押下で詳細な情報が閲覧できる画面に遷移してください
3. リストおよび詳細画面に表示する情報は自由に決めてください

## インストール方法
MacOSで開発を行いました。
多環境での動作確認はしておりません。

1. このプログラムは NSQ と MongoDB また、Goのパッケージ管理にdepを用いているためこれらをインストールします。
```
$ brew install nsq mongodb dep
```
2. コマンドをビルドします。
```
$ make
```

## 起動手順

1. NSQ と MongoDBを起動します。
```
$ nsqd nsqd --lookupd-tcp-address=localhost:4160
$ nsqlookupd
$ mkdir db
$ mongod --dbpath ./db
$ mongod
> use trendlist
> db.trends.insert({"title":"Github","list":[]})  
> exit
```

2. `resiver`を起動します。
```
$ ./build/resiver
```

3. `api`を起動します。

```
$ ./build/api 
```
3. `scraper`を起動します。
```
$ ./build/scraper
```

4. 最後に`web`を起動します。
```
$ ./build/web
```