package main

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"regexp"
	"strconv"
	"strings"

	"github.com/PuerkitoBio/goquery"
	"github.com/labstack/echo"
	"gopkg.in/russross/blackfriday.v2"
)

type repositoryInfo struct {
	FullName           string
	URL                string
	Description        string
	ProgramingLanguage string
	Color              string
	Star               int
	Fork               int
	StarToday          int
	Readme             string
}

func repository(c echo.Context) error {
	fullName := c.Param("user") + "/" + c.Param("repositoryName")
	data := parseRepository(fullName)

	// サイト情報の作成
	meta := createPageInfo(fullName, data)

	return c.Render(http.StatusOK, "repository", meta)
}

func parseRepository(fullName string) repositoryInfo {
	var repository repositoryInfo

	host := "https://github.com"
	repositoryURL := host + "/" + fullName
	doc, _ := goquery.NewDocument(repositoryURL)
	repository.FullName = fullName

	url := host + "/" + fullName
	repository.URL = url

	description := doc.Find("span[itemprop=\"about\"]").Text()
	description = strings.TrimSpace(description)
	repository.Description = description

	lang := doc.Find(".lang").First().Text()
	lang = strings.TrimSpace(lang)
	if lang == "" {
		lang = "(none)"
	}
	repository.ProgramingLanguage = lang

	color, has := doc.Find(".language-color").Attr("style")
	pattern := regexp.MustCompile(`background-color:(.)*;`)
	group := pattern.FindStringSubmatch(color)
	if has != true {
		color = "#000000"
	} else {
		color = strings.Replace(group[0], "background-color:", "", -1)
		color = strings.Replace(color, ";", "", -1)
	}
	repository.Color = color

	rstar := doc.Find(".social-count[href=\"/" + fullName + "/stargazers\"]").Text()
	rstar = strings.Replace(rstar, ",", "", -1)
	rstar = strings.TrimSpace(rstar)
	star, _ := strconv.Atoi(rstar)
	repository.Star = star

	rfork := doc.Find(".social-count[href=\"/" + fullName + "/network/members\"]").Text()
	rfork = strings.Replace(rfork, ",", "", -1)
	rfork = strings.TrimSpace(rfork)
	fork, _ := strconv.Atoi(rfork)
	repository.Fork = fork

	readmeFile := doc.Find("h3.Box-title").Text()
	readmeFile = strings.Replace(readmeFile, ",", "", -1)
	readmeFile = strings.TrimSpace(readmeFile)
	if readmeFile == "" {
		repository.Readme = ""
	} else {
		readmeURL := "https://raw.githubusercontent.com/" + fullName + "/master/" + readmeFile
		resp, err := http.Get(readmeURL)
		if err != nil {
			fmt.Println(err)
		}
		defer resp.Body.Close()
		body, err := ioutil.ReadAll(resp.Body)
		if err != nil {
			fmt.Println(err)
		}
		pos := strings.LastIndex(readmeFile, ".")
		if !(readmeFile[pos:] == ".md" || readmeFile[pos:] == ".markdown") {
			repository.Readme = string(body)
		} else {
			unsafe := blackfriday.Run(body)
			repository.Readme = string(unsafe)
		}
	}

	return repository
}
