package main

import (
	"io"
	"net/http"
	"strconv"
	"text/template"

	"github.com/labstack/echo"
)

// Template はTextテンプレート
// Markdown→HTMLに変更する際にサニタイズされる前の情報を流し込むためhtml/templateを不使用
type Template struct {
	templates *template.Template
}

// Render はTextテンプレートの作成
func (t *Template) Render(w io.Writer, name string, data interface{}, c echo.Context) error {
	return t.templates.ExecuteTemplate(w, name, data)
}

func customHTTPErrorHandler(err error, c echo.Context) {
	code := http.StatusInternalServerError
	if he, ok := err.(*echo.HTTPError); ok {
		code = he.Code
	}
	// ページ情報の作成
	meta := createPageInfo(strconv.Itoa(code), nil)

	c.Render(http.StatusOK, strconv.Itoa(code), meta)

	c.Logger().Error(err)
}

// ページ情報
type pageInfo struct {
	SiteName string
	Title    string
	Lang     string
	Charset  string
	Data     interface{}
}

// ページ情報の作成
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

	template := &Template{
		templates: template.Must(template.ParseGlob("templates/*.html")),
	}
	e.Renderer = template

	e.HTTPErrorHandler = customHTTPErrorHandler

	e.Static("/static", "assets")

	e.GET("/", trend)
	e.GET("/repo/:user/:repositoryName", repository)

	e.Logger.Fatal(e.Start(":8000"))
}
