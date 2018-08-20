package main

import (
	"net/http"
	"strconv"
	"strings"

	"github.com/PuerkitoBio/goquery"
	"github.com/labstack/echo"
)

func trend(c echo.Context) error {
	data := parseTrending()

	// サイト情報の作成
	meta := createPageInfo("GitHub Trending", data)

	return c.Render(http.StatusOK, "index", meta)
}

func parseTrending() []repositoryInfo {
	var repositories []repositoryInfo

	host := "https://github.com"
	trending := host + "/trending"
	doc, _ := goquery.NewDocument(trending)
	doc.Find(".repo-list > li").Each(func(_ int, s *goquery.Selection) {
		var repository repositoryInfo

		fullName := s.Find("h3").Text()
		fullName = strings.TrimSpace(fullName)
		fullName = strings.Replace(fullName, " ", "", -1)
		repository.FullName = fullName

		url := host + "/" + fullName
		repository.URL = url

		description := s.Find(".py-1 > p").Text()
		description = strings.TrimSpace(description)
		repository.Description = description

		lang := s.Find("span[itemprop=\"programmingLanguage\"]").Text()
		lang = strings.TrimSpace(lang)
		if lang == "" {
			lang = "(none)"
		}
		repository.ProgramingLanguage = lang

		color, has := s.Find(".repo-language-color").Attr("style")
		if has != true {
			color = "#000000"
		} else {
			color = strings.Replace(color, "background-color:", "", -1)
			color = strings.Replace(color, ";", "", -1)
		}
		repository.Color = color

		rstar := s.Find(".muted-link[href=\"/" + fullName + "/stargazers\"]").Text()
		rstar = strings.Replace(rstar, ",", "", -1)
		rstar = strings.TrimSpace(rstar)
		star, _ := strconv.Atoi(rstar)
		repository.Star = star

		rfork := s.Find(".muted-link[href=\"/" + fullName + "/network\"]").Text()
		rfork = strings.Replace(rfork, ",", "", -1)
		rfork = strings.TrimSpace(rfork)
		fork, _ := strconv.Atoi(rfork)
		repository.Fork = fork

		rtoday := s.Find(".d-inline-block.float-sm-right").Text()
		rtoday = strings.Replace(rtoday, ",", "", -1)
		rtoday = strings.Replace(rtoday, " stars today", "", -1)
		rtoday = strings.TrimSpace(rtoday)
		today, _ := strconv.Atoi(rtoday)
		repository.StarToday = today

		repositories = append(repositories, repository)
	})

	return repositories
}
