package controllers

import (
	"encoding/json"
	"fmt"
	"github.com/PuerkitoBio/goquery"
	"strconv"
	"strings"
)

type Data struct {
	Name string `json:"name"`
	Info string `json:"info"`
	Star int    `json:"star"`
	Lang string `json:"lang"`
	Fork int    `json:"fork"`
	Link string `json:"link"`
}

func getData(url string) (datas []*Data) {
	for i := 0; i < 25; i++ {
		datas = append(datas, new(Data))
	}
	doc, err := goquery.NewDocument(url)
	if err != nil {
		fmt.Print("url scarapping failed")
	}

	doc.Find(".repo-list li").Each(func(i int, s *goquery.Selection) {
		name := strings.Replace(strings.Replace(s.Find("h3").Text(), " ", "", -1), "\n", "", -1)
		datas[i].Name = name

		link, _ := s.Find("h3 a").Attr("href")
		datas[i].Link = link

		info := strings.Replace(s.Find(".py-1").Text(), "       ", "", 1)
		info = strings.Replace(info, "\n", " ", -1)
		datas[i].Info = info

		datas[i].Lang = strings.Replace(strings.Replace(s.Find("span[itemprop='programmingLanguage']").Text(), " ", "", -1), "\n", "", -1)

		starStr := s.Find("svg[aria-label='star']").Parent().Text()
		star := strings.Replace(strings.Replace(strings.Replace(starStr, " ", "", -1), ",", "", -1), "\n", "", -1)
		datas[i].Star, _ = strconv.Atoi(star)

		forkStr := s.Find("svg[aria-label='fork']").Parent().Text()
		fork := strings.Replace(strings.Replace(strings.Replace(forkStr, " ", "", -1), ",", "", -1), "\n", "", -1)
		datas[i].Fork, _ = strconv.Atoi(fork)

	})
	/*
		doc.Find("div.py-1 > p").Each(func(i int, s *goquery.Selection) {
			info := strings.Replace(s.Text(), "        ", "", 1)
			info = strings.Replace(info, "\n", " ", -1)
			datas[i].Info = info
		})
		doc.Find("span[itemprop='programmingLanguage']").Each(func(i int, s *goquery.Selection) {
			datas[i].Lang = strings.Replace(strings.Replace(s.Text(), " ", "", -1), "\n", "", -1)
		})
		doc.Find("svg[aria-label='star']").Each(func(i int, s *goquery.Selection) {
			str := s.Parent().Text()
			star := strings.Replace(strings.Replace(strings.Replace(str, " ", "", -1), ",", "", -1), "\n", "", -1)
			datas[i].Star, _ = strconv.Atoi(star)
		})
		doc.Find("svg[aria-label='fork']").Each(func(i int, s *goquery.Selection) {
			str := s.Parent().Text()
			fork := strings.Replace(strings.Replace(strings.Replace(str, " ", "", -1), ",", "", -1), "\n", "", -1)
			datas[i].Fork, _ = strconv.Atoi(fork)
		})
	*/
	return datas
}

func getJSON(url string) (r []byte) {
	r, _ = json.Marshal(getData(url))
	return r
}
