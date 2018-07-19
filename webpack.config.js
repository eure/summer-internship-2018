const path = require('path');

module.exports = {
    // ビルドのエントリポイント
    entry: path.join(__dirname, 'src/js/index.js'),
    output: {
        // ビルドファイルの出力先
        path: path.join(__dirname, 'dist'),
        // 出力ファイル名
        filename: 'bundle.js'
    },
    module: {
        rules: [
            {
                // (babelでの)ビルド対象を正規表現で指定
                test: /\.(js|jsx)$/,
                // babel-loaderでES6をES5にトランスパイル
                loader: 'babel-loader',
                query: {
                    presets: ['env', 'react']
                },
                // モジュールはビルド対象外
                exclude: /node_modules/
            },
            {
                test: /\.css$/,
                loaders: ['style-loader', 'css-loader']
            },
        ]
    },
    devServer: {
        // サーバーの読み取り先
        contentBase: path.join(__dirname, 'dist'),
        port: 3000,
        // ファイルに変更があったら自動で更新
        inline: true,
        // サーバー起動後ブラウザを自動起動
        open: true,
    },
};