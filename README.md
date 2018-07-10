### 仕様説明
#### 実現した機能の簡単な解説
 - 自身[reima21]のリポジトリ一覧を取得し, テーブルビューに表示.（図1）
 - リスト押下でそのリポジトリのwebページを表示。左上のcloseボタンでリポジトリ一覧に戻る.（図2）

#### スクリーンショット

図1
![Alt text](./images/image1.png?raw=true "image1")

図2
![Alt text](./images/image2.png?raw=true "image2")

### 環境構築マニュアル
Cartfileがある summer-internship-2018/summer-internship-2018 ディレクトリ内で以下のコードを実行.

```
carthage update --platform iOS
```

### 言語/ライブラリ/アーキテクチャなどの選定理由
 - 言語 : 指定があったためSwiftを選定.
 - ライブラリ : Alamofireは通信、SwiftyJSONはJSONを簡単に扱えるため選定.
 - アーキテクチャ : 構造が明確なためMVCを採用.

### こだわりポイント
 - ライブラリの導入によりコード量を減らした.
 - storyboardを使用せずコードで実装することにより仕様変更に対応しやすくした.
