package main

import (
	"net/http"
	"strconv"
	"strings"

	"github.com/PuerkitoBio/goquery"
	"github.com/labstack/echo"
)

func trend(c echo.Context) error {
	data := parse()

	// サイト情報の作成
	meta := createPageInfo("GitHub Trending", data)

	return c.Render(http.StatusOK, "index", meta)
}
func parseName(s *goquery.Selection) string {
	rtitle := s.Find("h3").Text()
	rtitle = strings.TrimSpace(rtitle)
	title := strings.Replace(rtitle, " ", "", -1)
	return title
}

func parseURL(s *goquery.Selection) string {
	rurl, _ := s.Find("h3 > a").Attr("href")
	url := "https://github.com" + rurl
	return url
}

func parseDescription(s *goquery.Selection) string {
	rdescription := s.Find(".py-1 > p").Text()
	description := strings.TrimSpace(rdescription)
	return description
}

func parseProgramingLanguage(s *goquery.Selection) string {
	rlang := s.Find("span[itemprop=\"programmingLanguage\"]").Text()
	lang := strings.TrimSpace(rlang)
	return lang
}

func parseStar(s *goquery.Selection) int {
	url := parseURL(s)
	rurl := strings.Replace(url, "https://github.com", "", -1)

	rstar := s.Find(".muted-link[href=\"" + rurl + "/stargazers\"]").Text()
	rstar = strings.Replace(rstar, ",", "", -1)
	rstar = strings.TrimSpace(rstar)
	star, _ := strconv.Atoi(rstar)
	return star
}

func parseFork(s *goquery.Selection) int {
	url := parseURL(s)
	rurl := strings.Replace(url, "https://github.com", "", -1)

	rfork := s.Find(".muted-link[href=\"" + rurl + "/network\"]").Text()
	rfork = strings.Replace(rfork, ",", "", -1)
	rfork = strings.TrimSpace(rfork)
	fork, _ := strconv.Atoi(rfork)
	return fork
}

func parseStarToday(s *goquery.Selection) int {
	rtoday := s.Find(".d-inline-block.float-sm-right").Text()
	rtoday = strings.Replace(rtoday, ",", "", -1)
	rtoday = strings.Replace(rtoday, " stars today", "", -1)
	rtoday = strings.TrimSpace(rtoday)
	today, _ := strconv.Atoi(rtoday)
	return today
}

type repositoryInfo struct {
	Name               string
	URL                string
	Description        string
	ProgramingLanguage string
	Star               int
	Fork               int
	StarToday          int
}

func parse() []repositoryInfo {
	var repositories []repositoryInfo

	trend := "https://github.com/trending"
	doc, _ := goquery.NewDocument(trend)
	doc.Find(".repo-list > li").Each(func(_ int, s *goquery.Selection) {

		var repository repositoryInfo
		repository.Name = parseName(s)
		repository.URL = parseURL(s)
		repository.Description = parseDescription(s)
		repository.ProgramingLanguage = parseProgramingLanguage(s)
		repository.Star = parseStar(s)
		repository.Fork = parseFork(s)
		repository.StarToday = parseStarToday(s)

		repositories = append(repositories, repository)
	})

	return repositories
}
