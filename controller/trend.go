package controller

import (
	"fmt"
	"html/template"
	"net/http"
	"time"

	"github.com/summer-internship-2018/model"
)

//　テンプレートに渡す情報の構造体
type TrendContent struct {
	Trend     []string
	developer []string
}

//　取得したトレンド情報を返す
func GetTrends(w http.ResponseWriter, r *http.Request) {
	fmt.Println(time.Now().Format("2006/01/02 15:04:05") + " " + r.URL.Path)

	// テンプレート用のファイルを読み込む
	tpl, err := template.ParseFiles("view/trend.html")
	if err != nil {
		panic(err)
	}

	// トレンド情報と開発者のトレンドをもらう
	trends := model.GetTrend()
	develop := model.GetDeveloperTrend()

	tpl.Execute(w, map[string]interface{}{
		"Trend":   trends,
		"Develop": develop,
	})
}
