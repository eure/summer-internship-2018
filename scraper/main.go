package main

import (
	"log"
	"os"
	"os/signal"
	"sync"
	"syscall"

	nsq "github.com/bitly/go-nsq"
)

// 投票結果をNSQにパブリッシュする
func publishLists(lists <-chan string) <-chan struct{} {
	stopChan := make(chan struct{}, 1)
	pub, err := nsq.NewProducer("localhost:4150", nsq.NewConfig())
	if err != nil {
		log.Println(err)
	}
	go func() {
		for list := range lists {
			log.Println("デバッグ:", list)
			pub.Publish("lists", []byte(list))
		}
		log.Println("Publisher: 停止中です")
		pub.Stop()
		log.Println("Publisher: 停止しました")
		stopChan <- struct{}{}
	}()
	return stopChan
}

func main() {
	var stoplock sync.Mutex
	stop := false
	stopChan := make(chan struct{}, 1)
	signalChan := make(chan os.Signal, 1)

	go func() {
		<-signalChan
		stoplock.Lock()
		stop = true
		stoplock.Unlock()
		log.Println("Stoping ... ")
		stopChan <- struct{}{}
	}()

	signal.Notify(signalChan, syscall.SIGINT, syscall.SIGTERM)

	// 処理の開始
	lists := make(chan string)
	publisherStoppedChan := publishLists(lists)
	githubStoppedChan := startGitHubScraping(stopChan, lists)

	<-githubStoppedChan
	close(lists)
	<-publisherStoppedChan
}
