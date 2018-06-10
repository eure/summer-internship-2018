package main

import (
    "fmt"
	"log"
	"net/http"
	"text/template"
	"github.com/andygrunwald/go-trending"
)

type Person struct {
    Projects    []trending.Project
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

func Handler(w http.ResponseWriter, r *http.Request) {
    projects := getProjects()

    p := Person{
        Projects:  projects,
    }

    tmpl := template.Must(template.ParseFiles("../src/templates/index.tpl"))
    tmpl.Execute(w, p)
}
func main() {
    // Server
	//http.Handle("/", &templateHandler{filename: "index.tpl")
    http.HandleFunc("/", Handler)

	if err := http.ListenAndServe(":8080", nil); err != nil {
		log.Fatal("ListenAndServe:", err)
	}
}
