package main

import (
	"bytes"
	"log"
	"sync"
	"time"

	"github.com/PuerkitoBio/goquery"
)

const url = "https://github.com/trending"

var (
	setupOnce   sync.Once
	checkUpdate []byte
)

// 一定時間ごとにアクセスして取得する
// 該当部分をバイトに直し比較することで、更新があるかどうかチェック
// 更新があれば、チャネルにながしなければそのまま終える。
func readFromGitHub(lists chan<- string) {
	doc, err := goquery.NewDocument(url)
	if err != nil {
		panic(err)
	}
	session := doc.Find("ol.repo-list > li.col-12.d-block > div.d-inline-block > h3 > a")
	if !bytes.Equal(checkUpdate, []byte(session.Text())) {
		log.Println("トレンドリストの更新あり")
		session.Each(func(_ int, s *goquery.Selection) {
			link, _ := s.Attr("href")
			lists <- link
		})
	} else {
		log.Println("トレンドリストの更新なし")
	}
	checkUpdate = []byte(session.Text())
}

// Githubのスクレイピングworker
// 10秒ごとに更新をチェックしにいく
func startGitHubScraping(stopchan <-chan struct{}, lists chan<- string) <-chan struct{} {
	stoppedChan := make(chan struct{}, 1)
	go func() {
		defer func() {
			stoppedChan <- struct{}{}
		}()
		for {
			select {
			case <-stopchan:
				log.Println("GitHubのトレンドリストの取得を終了します")
				return
			default:
				log.Println("Githubのトレンドリストを取得します...")
				readFromGitHub(lists)
				log.Println("(待機中)")
				time.Sleep(10 * time.Second)
			}
		}
	}()
	return stoppedChan
}
