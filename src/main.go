package main

import (
    "fmt"
	"log"
    "strings"
	"net/http"
	"text/template"
	"github.com/andygrunwald/go-trending"
)

type Person struct {
    Projects    []trending.Project
}

type Repo struct {
    Name    string
    Url     string
}

func getProjects() []trending.Project {
    // Github trend
	trend := trending.NewTrending()

	projects, err := trend.GetProjects(trending.TimeToday, "")
	if err != nil {
		log.Fatal("GetProjects", err)
	}

	for index, project := range projects {
		no := index + 1
		if len(project.Language) > 0 {
			fmt.Printf("%d: %s (written in %s with %d * )\n", no, project.Name, project.Language, project.Stars)
		} else {
			fmt.Printf("%d: %s (with %d * )\n", no, project.Name, project.Stars)
		}
	}
    return projects
}

func rootHandler(w http.ResponseWriter, r *http.Request) {
    projects := getProjects()

    p := Person{
        Projects:  projects,
    }

    tmpl := template.Must(template.ParseFiles("../src/templates/index.tpl"))
    tmpl.Execute(w, p)
}

func detailHandler(w http.ResponseWriter, r *http.Request) {
    fmt.Print(r.URL.RawQuery)

    q := r.URL.Query()
    name := strings.Replace(q["repo"][0], " ", "", -1)  // trim all %20
    d := Repo{
        Name:   name,   //[0]:[]string to string
        Url:    "https://github.com/" + name,
    }

    tmpl := template.Must(template.ParseFiles("../src/templates/detail.tpl"))
    tmpl.Execute(w, d)
}

func main() {
    // Server
	//http.Handle("/", &templateHandler{filename: "index.tpl")
    http.HandleFunc("/", rootHandler)
    http.HandleFunc("/detail/", detailHandler)

	if err := http.ListenAndServe(":8080", nil); err != nil {
		log.Fatal("ListenAndServe:", err)
	}
}
