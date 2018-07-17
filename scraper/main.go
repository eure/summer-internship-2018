package main

import (
	"log"
	"os"
	"os/signal"
	"syscall"

	"github.com/bitly/go-nsq"
	"context"
)


// 投票結果をNSQにパブリッシュする
func publishLists(lists <-chan string) {
	pub, err := nsq.NewProducer("localhost:4150", nsq.NewConfig())
	if err != nil {
		log.Println(err)
	}
		for list := range lists {
			log.Println("デバッグ:", list)
			pub.Publish("lists", []byte(list))
		}
		log.Println("Publisher: 停止中です")
		pub.Stop()
		log.Println("Publisher: 停止しました")
}

func main() {
	ctx, cancel := context.WithCancel(context.Background())
	signalChan := make(chan os.Signal, 1)

	go func() {
		<-signalChan
		cancel()
		log.Println("Stoping ... ")
	}()
	signal.Notify(signalChan, syscall.SIGINT, syscall.SIGTERM)

	// 処理の開始
	lists := make(chan string)
	go githubScraping(ctx, lists)
	publishLists(lists)

}
