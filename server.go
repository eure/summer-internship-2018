package main

import (
	"net/http"

	"github.com/summer-internship-2018/controller"
)

func main() {

	// 静的ファイルの読み込み
	http.Handle("/assets/", http.StripPrefix("/assets/", http.FileServer(http.Dir("assets/"))))

	// ルーティング
	http.HandleFunc("/", controller.GetTrends)
	http.HandleFunc("/detail", controller.GetDetail)

	// サーバ起動　→　localhost:8080で監視
	http.ListenAndServe(":8080", nil)
}
