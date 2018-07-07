package model

import (
	"log"
	"net/url"

	"github.com/andygrunwald/go-trending"
)

// トレンド情報の構造体
type TrendItem struct {
	Rank           int
	RepositoryName string
	Owner          string
	Description    string
	Star           int
}

// 開発者レンド情報の構造体
type DeveloperItem struct {
	Rank        int
	Id          int
	DisplayName string
	FullName    string
	Avatar      *url.URL
}

// トレンド情報を取得する
func GetTrend() []TrendItem {
	trend := trending.NewTrending()

	// 今日のトレンド情報を参照
	projects, err := trend.GetProjects(trending.TimeToday, "")
	if err != nil {
		log.Fatal(err)
	}

	// トレンド情報を入れる箱を用意
	TrendItems := make([]TrendItem, 25)

	// 欲しい情報を取り出し・格納
	for count, project := range projects {
		rank := count + 1
		TrendItems[count] = TrendItem{Rank: rank, RepositoryName: project.RepositoryName, Description: project.Description, Owner: project.Owner, Star: project.Stars}
	}

	return TrendItems
}

// 開発者トレンドを取得する
func GetDeveloperTrend() []DeveloperItem {
	trend := trending.NewTrending()

	// 今日の開発者トレンド情報を参照
	developers, err := trend.GetDevelopers(trending.TimeToday, "")
	if err != nil {
		log.Fatal(err)
	}

	// トレンド情報を入れる箱を用意
	DeveloperItems := make([]DeveloperItem, 25)

	// 欲しい情報を取り出し・格納
	for count, developer := range developers {
		rank := count + 1
		DeveloperItems[count] = DeveloperItem{Rank: rank, Id: developer.ID, DisplayName: developer.DisplayName, FullName: developer.FullName, Avatar: developer.Avatar}
	}

	return DeveloperItems
}
