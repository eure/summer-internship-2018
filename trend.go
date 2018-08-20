package main

import (
	"net/http"
	"strconv"
	"strings"
	"time"

	"github.com/PuerkitoBio/goquery"
	"github.com/labstack/echo"
	"github.com/patrickmn/go-cache"
)

// /trendにアクセスしたときに実行
func trend(c echo.Context) error {
	// キャッシュの有効期限を1時間、破棄時間を12時間にセット
	cch := cache.New(60*time.Minute, 720*time.Minute)
	// キャッシュから読み出し
	meta, found := cch.Get("meta")
	// キャッシュがなければデータをセット
	if !found {
		// サイトに流し込むデータ
		data := parseTrending()
		// ページ情報の作成
		meta = createPageInfo("GitHub Trending", data)
		// キャッシュをセット
		cch.Set("meta", meta, cache.DefaultExpiration)
	}

	return c.Render(http.StatusOK, "index", meta.(*pageInfo))
}

// Github Trendingのパース
func parseTrending() []repositoryInfo {
	var repositories []repositoryInfo

	host := "https://github.com"
	trending := host + "/trending"
	doc, _ := goquery.NewDocument(trending)
	doc.Find(".repo-list > li").Each(func(_ int, s *goquery.Selection) {
		var repository repositoryInfo

		// レポジトリーの名前(user/reposidtory)の取得
		fullName := s.Find("h3").Text()
		fullName = strings.TrimSpace(fullName)
		fullName = strings.Replace(fullName, " ", "", -1)
		repository.FullName = fullName

		// レポジトリーのURLの取得
		url := host + "/" + fullName
		repository.URL = url

		// レポジトリーの説明文の取得
		description := s.Find(".py-1 > p").Text()
		description = strings.TrimSpace(description)
		repository.Description = description

		// レポジトリーの主要言語の取得
		lang := s.Find("span[itemprop=\"programmingLanguage\"]").Text()
		lang = strings.TrimSpace(lang)
		if lang == "" {
			lang = "(none)"
		}
		repository.ProgramingLanguage = lang

		// レポジトリーの主要言語の色の取得
		color, has := s.Find(".repo-language-color").Attr("style")
		if has != true {
			color = "#000000"
		} else {
			color = strings.Replace(color, "background-color:", "", -1)
			color = strings.Replace(color, ";", "", -1)
		}
		repository.Color = color

		// レポジトリーのスター数の取得
		rstar := s.Find(".muted-link[href=\"/" + fullName + "/stargazers\"]").Text()
		rstar = strings.Replace(rstar, ",", "", -1)
		rstar = strings.TrimSpace(rstar)
		star, _ := strconv.Atoi(rstar)
		repository.Star = star

		// レポジトリーのフォーク数の取得
		rfork := s.Find(".muted-link[href=\"/" + fullName + "/network\"]").Text()
		rfork = strings.Replace(rfork, ",", "", -1)
		rfork = strings.TrimSpace(rfork)
		fork, _ := strconv.Atoi(rfork)
		repository.Fork = fork

		// レポジトリーの今日一日の増加スター数の取得
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
