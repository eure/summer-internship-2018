package main

import (
	"encoding/json"
	"flag"
	"fmt"
	"html/template"
	"log"
	"net/http"
	"path/filepath"
	"strings"
	"sync"
)

type templateHandler struct {
	once     sync.Once
	filename string
	function func() Trend
	templ    *template.Template
}

func (t *templateHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	t.once.Do(func() {
		t.templ = template.Must(template.ParseFiles(filepath.Join("web/templates", t.filename)))
	})
	if t.function != nil {
		data := t.function()
		t.templ.Execute(w, data[0])
	} else {
		param := r.URL.String()
		param = strings.Replace(param, "%2f", "/", -1)
		param = strings.Split(param, "=")[1]
		fmt.Println(param)
		res, err := http.Get("https://api.github.com/repos" + param)
		if err != nil {
			log.Fatalln(err)
		}
		var data Info
		defer res.Body.Close()
		if err := json.NewDecoder(res.Body).Decode(&data); err != nil {
			log.Fatalln(err)
		}
		t.templ.Execute(w, data)
	}
}

func main() {
	var addr = flag.String("addr", ":8081", "Webサイトのアドレス")
	flag.Parse()

	http.Handle("/", &templateHandler{filename: "index.html", function: getList})
	http.Handle("/detail", &templateHandler{filename: "detail.html", function: nil})
	log.Println("Webサーバを開始します。", *addr)
	if err := http.ListenAndServe(*addr, nil); err != nil {
		log.Fatal("ListenAndServe:", err)
	}
}

func getList() Trend {
	response, err := http.Get("http://localhost:8080/trends/?key=abc")
	if err != nil {
		log.Fatalln(err)
	}
	var data Trend
	defer response.Body.Close()
	if err := json.NewDecoder(response.Body).Decode(&data); err != nil {
		log.Fatalln(err)
	}
	return data
}
