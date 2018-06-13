# TrendMil
githubのトレンドリポジトリ一覧を表示するWebアプリケーションです．

#### 使用言語

* Ruby on Rails
* React
* es2015

#### 実行方法
必要なgemのインストール
```bash
$ bundle install
```
yarn インストール
```bash
$ curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
$ echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
$ sudo apt-get update && sudo apt-get install yarn
```

yarn初期化
```bash
$ yarn init
$ yarn install
```

必要なパッケージのインストール
```bash
$ rake webpacker:install
$ rake webpacker:install:react
$ yarn add babel-core babel-preset-es2015 babel-preset-react react react-dom react-router-dom axios lodash 
```
