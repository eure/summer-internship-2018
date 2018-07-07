package controller

import (
	"fmt"
	"net/http"
	"text/template"
	"time"

	"github.com/summer-internship-2018/model"
)

// 取得した詳細な情報を返す
func GetDetail(w http.ResponseWriter, r *http.Request) {
	fmt.Println(time.Now().Format("2006/01/02 15:04:05") + " " + r.URL.Path)

	// formから値を受け取る
	owner := r.FormValue("Owner")
	repository := r.FormValue("RepositoryName")

	// 受け取った値を渡す
	detail := model.GetDetail(owner, repository)

	// テンプレート用のファイルを読み込む
	tpl, err := template.ParseFiles("view/detail.html")
	if err != nil {
		panic(err)
	}

	tpl.Execute(w, detail)
}
