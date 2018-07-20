package main

import (
	"log"
	"os"
	"os/signal"
	"sync"
	"syscall"
	"time"

	"gopkg.in/mgo.v2"

	"github.com/bitly/go-nsq"
	"gopkg.in/mgo.v2/bson"
)

func main() {
	err := receiverMain()
	if err != nil {
		log.Fatal(err)
	}
}

func receiverMain() error {
	// データベース接続
	log.Println("データベースに接続します...")
	db, err := mgo.Dial("localhost")
	if err != nil {
		return err
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
		return err
	}

	q.AddHandler(nsq.HandlerFunc(func(m *nsq.Message) error {
		countsLock.Lock()
		defer countsLock.Unlock()
		log.Println("デバッグ:", string(m.Body))

		ranking = append(ranking, string(m.Body))
		return nil
	}))

	if err := q.ConnectToNSQLookupd("localhost:4161"); err != nil {
		return err
	}

	const updateDuration = 3 * time.Second

	ticker := time.NewTicker(updateDuration)
	defer ticker.Stop()

	update := func() {
		countsLock.Lock()
		defer countsLock.Unlock()
		if len(ranking) == 0 {
			log.Println("新しい更新はありません")
			return
		} else {
			log.Println("データベースを更新します")
			log.Println(ranking)

			sel := bson.M{"title": "Github"}
			up := bson.M{"$set": bson.M{"list": ranking}}
			if _, err := pollData.UpdateAll(sel, up); err != nil {
				log.Println("更新に失敗しました:", err)
			}
		}
		ranking = nil
	}

	termChan := make(chan os.Signal, 1)
	signal.Notify(termChan, syscall.SIGINT, syscall.SIGTERM, syscall.SIGHUP)

	for {
		select {
		case <-ticker.C:
			update()
		case <-termChan:
			q.Stop()
		case <-q.StopChan:
			// 完了しました
			return  nil
		}
	}
}
