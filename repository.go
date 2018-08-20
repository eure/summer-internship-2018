package main

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"regexp"
	"strconv"
	"strings"
	"time"

	"github.com/PuerkitoBio/goquery"
	"github.com/labstack/echo"
	cache "github.com/patrickmn/go-cache"
	"gopkg.in/russross/blackfriday.v2"
)

// レポジトリー情報
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

// /repo/:user/:repositoryにアクセスしたときに実行
func repository(c echo.Context) error {
	// キャッシュの有効期限を12時間、破棄時間を24時間にセット
	cch := cache.New(720*time.Minute, 1440*time.Minute)

	fullName := c.Param("user") + "/" + c.Param("repositoryName")
	// キャッシュから読み出し
	meta, found := cch.Get(fullName)
	// キャッシュがなければデータをセット
	if !found {
		// サイトに流し込むデータ
		data := parseRepository(fullName)
		// ページ情報の作成
		meta = createPageInfo(fullName, data)
		// キャッシュをセット
		cch.Set("meta", meta, cache.DefaultExpiration)
	}

	return c.Render(http.StatusOK, "repository", meta.(*pageInfo))
}

func parseRepository(fullName string) repositoryInfo {
	var repository repositoryInfo

	host := "https://github.com"
	repositoryURL := host + "/" + fullName
	doc, _ := goquery.NewDocument(repositoryURL)

	// レポジトリーの名前(user/reposidtory)の取得
	repository.FullName = fullName

	// レポジトリーのURLの取得
	url := host + "/" + fullName
	repository.URL = url

	// レポジトリーの説明文の取得
	description := doc.Find("span[itemprop=\"about\"]").Text()
	description = strings.TrimSpace(description)
	repository.Description = description

	// レポジトリーの主要言語の取得
	lang := doc.Find(".lang").First().Text()
	lang = strings.TrimSpace(lang)
	if lang == "" {
		lang = "(none)"
	}
	repository.ProgramingLanguage = lang

	// レポジトリーの主要言語の色の取得
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

	// レポジトリーのスター数の取得
	stringStar := doc.Find(".social-count[href=\"/" + fullName + "/stargazers\"]").Text()
	stringStar = strings.Replace(stringStar, ",", "", -1)
	stringStar = strings.TrimSpace(stringStar)
	star, _ := strconv.Atoi(stringStar)
	repository.Star = star

	// レポジトリーのフォーク数の取得
	stringFork := doc.Find(".social-count[href=\"/" + fullName + "/network/members\"]").Text()
	stringFork = strings.Replace(stringFork, ",", "", -1)
	stringFork = strings.TrimSpace(stringFork)
	fork, _ := strconv.Atoi(stringFork)
	repository.Fork = fork

	// Readmeファイルの名前を取得
	readmeFile := doc.Find("h3.Box-title").Text()
	readmeFile = strings.Replace(readmeFile, ",", "", -1)
	readmeFile = strings.TrimSpace(readmeFile)
	// ファイルがなければ空にする
	if readmeFile == "" {
		repository.Readme = ""
	} else {
		// ファイルの情報を取得
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
		// Markdownでなければそのまま登録
		if !(readmeFile[pos:] == ".md" || readmeFile[pos:] == ".markdown") {
			repository.Readme = string(body)
		} else {
			// Markdown→HTMLに変換して登録
			unsafe := blackfriday.Run(body)
			repository.Readme = string(unsafe)
		}
	}

	return repository
}
