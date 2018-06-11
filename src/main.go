package main

import (
	"context"
	"fmt"
	"github.com/andygrunwald/go-trending"
	"github.com/google/go-github/github"
	"log"
	"net/http"
	"strings"
	"text/template"
)

type Person struct {
	Projects []trending.Project
}

type Repo struct {
    Rank            string
	Name            string
    Owner           string
    RepositoryName  string
	Url             string
	ReadmeHTML      string
}

func main() {
	// Server
	http.Handle("/css/", http.StripPrefix("/css/", http.FileServer(http.Dir("../src/css"))))
	http.HandleFunc("/", rootHandler)
	http.HandleFunc("/detail/", detailHandler)

	if err := http.ListenAndServe(":8080", nil); err != nil {
		log.Fatal("ListenAndServe:", err)
	}
}

func rootHandler(w http.ResponseWriter, r *http.Request) {
	projects := getProjects()

	p := Person{
		Projects: projects,
	}

	tmpl := template.Must(template.ParseFiles("../src/templates/index.html"))
	tmpl.Execute(w, p)
}

func detailHandler(w http.ResponseWriter, r *http.Request) {
	// Parse received query
	q := r.URL.Query()
    rank := q["rank"][0]
	name := q["repo"][0]
	owner := strings.Split(name, "/")[0]
	repo := strings.Split(name, "/")[1]

	// Get and render README of the repo
	client := github.NewClient(nil)
	readme := getReadmeHTML(client, getReadme(client, owner, repo), name)

	// Template
	d := Repo{
        Rank:           rank,
		Name:           name,
        Owner:          owner,
        RepositoryName: repo,
		Url:            "https://github.com/" + name,
		ReadmeHTML:     readme,
	}
	tmpl := template.Must(template.ParseFiles("../src/templates/detail.html"))
	tmpl.Execute(w, d)
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

func getReadme(client *github.Client, owner string, repo string) string {
	readme, _, err := client.Repositories.GetReadme(context.Background(), owner, repo, nil)
	if err != nil {
		log.Fatal("GetReadme", err)
	}

	content, err := readme.GetContent()
	if err != nil {
		log.Fatal("GetContent", err)
	}

	return content
}

func getReadmeHTML(client *github.Client, readme string, repo_context string) string {
	opt := &github.MarkdownOptions{Mode: "gfm", Context: repo_context}

	output, _, err := client.Markdown(context.Background(), readme, opt)
	if err != nil {
		log.Fatal("Markdown", err)
	}

	return output
}
