package model

import (
	"context"
	"log"

	"github.com/google/go-github/github"
)

// 詳細情報の構造体
type DetailItem struct {
	Title  string
	Readme string
}

// 詳細な情報を取得する
func GetDetail(owner string, repository string) DetailItem {

	client := github.NewClient(nil)

	// READMEの取得
	readme := getReadmeHTML(client, getReadme(client, owner, repository), owner)

	// 詳細な情報を格納
	detail := DetailItem{Title: owner + "/" + repository, Readme: readme}

	return detail
}

// README情報の取得
func getReadme(client *github.Client, owner string, repository string) string {
	readme, _, err := client.Repositories.GetReadme(context.Background(), owner, repository, nil)
	if err != nil {
		log.Fatal("README取得", err)
	}

	content, err := readme.GetContent()
	if err != nil {
		log.Fatal("コンテンツ取得", err)
	}

	return content
}

// README情報をマークダウン
func getReadmeHTML(client *github.Client, readme string, repository_context string) string {

	opt := &github.MarkdownOptions{Mode: "gfm", Context: repository_context}

	output, _, err := client.Markdown(context.Background(), readme, opt)
	if err != nil {
		log.Fatal("マークダウン", err)
	}

	return output
}
