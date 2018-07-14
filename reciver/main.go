package main

import (
	"flag"
	"fmt"
	"log"
	"os"
	"os/signal"
	"sync"
	"syscall"
	"time"

	mgo "gopkg.in/mgo.v2"

	nsq "github.com/bitly/go-nsq"
	"gopkg.in/mgo.v2/bson"
)

var fatalErr error

func fatal(e error) {
	fmt.Println(e)
	flag.PrintDefaults()
	fatalErr = e
}

func main() {
	defer func() {
		if fatalErr != nil {
			os.Exit(1)
		}
	}()

	// データベース接続
	log.Println("データベースに接続します...")
	db, err := mgo.Dial("localhost")
	if err != nil {
		fatal(err)
		return
	}
	defer func() {
		log.Println("データベース接続を閉じます...")
		db.Close()
	}()
	pollData := db.DB("trendlist").C("trends")

	//
	var countsLock sync.Mutex
	var ranking []string

	log.Println("NSQに接続します")
	q, err := nsq.NewConsumer("lists", "list", nsq.NewConfig())
	if err != nil {
		fatal(err)
		return
	}

	q.AddHandler(nsq.HandlerFunc(func(m *nsq.Message) error {
		countsLock.Lock()
		defer countsLock.Unlock()
		log.Println("デバッグ:", string(m.Body))

		ranking = append(ranking, string(m.Body))
		return nil
	}))

	if err := q.ConnectToNSQLookupd("localhost:4161"); err != nil {
		fatal(err)
		return
	}

	const updateDuration = 3 * time.Second

	log.Println("NSQ上での取得を待機する...")
	var updater *time.Timer
	updater = time.AfterFunc(updateDuration, func() {
		countsLock.Lock()
		defer countsLock.Unlock()
		if len(ranking) == 0 {
			log.Println("新しい更新はありません")
		} else {
			log.Println("データベースを更新します")
			log.Println(ranking)

			sel := bson.M{"title": "Github"}
			up := bson.M{"$set": bson.M{"list": ranking}}
			if _, err := pollData.UpdateAll(sel, up); err != nil {
				log.Println("更新に失敗しました:", err)
			}

			ranking = nil
		}
		updater.Reset(updateDuration)
	})

	termChan := make(chan os.Signal, 1)
	signal.Notify(termChan, syscall.SIGINT, syscall.SIGTERM, syscall.SIGHUP)
	for {
		select {
		case <-termChan:
			updater.Stop()
			q.Stop()
		case <-q.StopChan:
			// 完了しました
			return
		}
	}
}
