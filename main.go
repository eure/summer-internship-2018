package main

import (
	"html/template"
	"io"

	"github.com/labstack/echo"
)

// Template はHTMLテンプレート
type Template struct {
	templates *template.Template
}

// Render はHTMLテンプレートの作成
func (t *Template) Render(w io.Writer, name string, data interface{}, c echo.Context) error {
	return t.templates.ExecuteTemplate(w, name, data)
}

type pageInfo struct {
	SiteName string
	Title    string
	Lang     string
	Charset  string
	Data     interface{}
}

func createPageInfo(title string, data interface{}) *pageInfo {
	info := &pageInfo{
		"エウレカ サマーインターンシップ 2018",
		title,
		"ja",
		"UTF-8",
		data,
	}
	return info
}

func main() {
	e := echo.New()

	// HTMLテンプレートの作成
	template := &Template{
		templates: template.Must(template.ParseGlob("templates/*.html")),
	}
	e.Renderer = template

	e.GET("/", trend)

	e.Logger.Fatal(e.Start(":8000"))
}
