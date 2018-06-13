package main

import (
	"context"
	"database/sql"
	"fmt"
	"github.com/andygrunwald/go-trending"
	"github.com/google/go-github/github"
	_ "github.com/mattn/go-sqlite3"
	"log"
	"net/http"
	"os"
	"os/signal"
	"strconv"
	"strings"
	"syscall"
	"text/template"
	"time"
)

type TrendProject struct {
	Rank    int
	Updown  string
	Project trending.Project
}

//for template (index.html)
type Trends struct {
	TrendProjects []TrendProject
}

// for template (detail.html)
type Repo struct {
	Rank           string
	Name           string
	Owner          string
	RepositoryName string
	Url            string
	ReadmeHTML     string
}

func main() {
	// Config server
	fmt.Println("Github Trend List Server")

	http.Handle("/css/", http.StripPrefix("/css/", http.FileServer(http.Dir("../src/css"))))
	http.HandleFunc("/", rootHandler)
	http.HandleFunc("/detail/", detailHandler)

	srv := &http.Server{Addr: ":8080"}
	fmt.Println("Port 8080")

	// Start server
	go func() {
		if err := srv.ListenAndServe(); err != nil {
			log.Fatal("ListenAndServe:", err)
		}
	}()
	fmt.Println("Server start")

	// Wait signal
	sigCh := make(chan os.Signal, 1)
	signal.Notify(sigCh, syscall.SIGINT, syscall.SIGTERM)
	<-sigCh

	// Graceful shutdown
	fmt.Print("Shutdown...")

	ctx, _ := context.WithTimeout(context.Background(), 5*time.Second)
	if err := srv.Shutdown(ctx); err != nil {
		log.Fatal("Shutdown", err)
	}

	fmt.Println("done")
}

func rootHandler(w http.ResponseWriter, r *http.Request) {
	// Get trend repos slice
	projects := getProjects()

	// Update database, and get a slice of TrendProject
	t := updateDB(projects)

	// Render template
	p := Trends{
		TrendProjects: t,
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

	// Get and render the README of the repo
	client := github.NewClient(nil)
	readme := getReadmeHTML(client, getReadmeMd(client, owner, repo), name)

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

	return projects
}

func updateDB(projects []trending.Project) []TrendProject {
    /* 
     * db       : trend.sqlite3
     * table    : rank
     * column   : repo text, last_rank integer
     * 
     * if not in top n (n=25?), last_rank = 0 (default)
     */

	db, err := sql.Open("sqlite3", "../src/trend.sqlite3")
	if err != nil {
		log.Fatal("sql.Open", err)
	}

	t := make([]TrendProject, 0)
	for i, p := range projects {
		rank := i + 1
		var lastrank int
		var updown string

		// Get the last rank of the repo "p"
		row := db.QueryRow("select last_rank from rank where repo=\"" + p.Name + "\";")
		err := row.Scan(&lastrank)

		// Set up-down value
		switch {
		case err == sql.ErrNoRows:
			updown = "new"
		case err != nil:
			log.Fatal("Scan", err)
		default:
			if lastrank <= 0 {
				updown = "new"
			} else if rank > lastrank {
				updown = "↓"
			} else if rank < lastrank {
				updown = "↑"
			} else {
				updown = "→"
			}
		}

		// Add trend data
		t = append(t, TrendProject{Rank: rank, Updown: updown, Project: p})
	}

	// Clear last_rank column
	_, err = db.Exec("update rank set last_rank=0;")
	if err != nil {
		log.Fatal("db.Exec clear", err)
	}

	// Update last_rank column
	for i, p := range projects {
		_, err = db.Exec("replace into rank(repo, last_rank) values(\"" + p.Name + "\", " + strconv.Itoa(i+1) + ");")
		if err != nil {
			log.Fatal("db.Exec replace", i, err)
		}
	}

	err = db.Close()
	if err != nil {
		log.Fatal("db.Close", err)
	}

	return t
}

func getReadmeMd(client *github.Client, owner string, repo string) string {
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
