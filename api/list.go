package main

import (
	"fmt"
	"net/http"

	mgo "gopkg.in/mgo.v2"
	"gopkg.in/mgo.v2/bson"
)

type list struct {
	ID    bson.ObjectId `bson:"_id" json:"id"`
	Title string        `json:"title"`
	List  []string      `json:"list"`
}

func handlePolls(w http.ResponseWriter, r *http.Request) {
	switch r.Method {
	case "GET":
		handlePollsGet(w, r)
		return
	case "POST":
		handlePollsPost(w, r)
		return
	case "DELETE":
		handlePollsDelete(w, r)
		return
	case "OPTIONS":
		w.Header().Add("Access-Control-Allow-Methods", "DELETE")
		respond(w, r, http.StatusOK, nil)
		return
	}

	// 未対応のHTTPめそっど
	respondHTTPErr(w, r, http.StatusNotFound)
}

func handlePollsGet(w http.ResponseWriter, r *http.Request) {
	db := GetVar(r, "db").(*mgo.Database)
	c := db.C("trends")
	var q *mgo.Query
	p := NewPath(r.URL.Path)
	if p.HasID() {
		// 特定の調査項目の詳細
		q = c.FindId(bson.ObjectIdHex(p.ID))
	} else {
		q = c.Find(nil)
	}
	var result []*list
	if err := q.All(&result); err != nil {
		respondErr(w, r, http.StatusInternalServerError, err)
		return
	}
	respond(w, r, http.StatusOK, &result)

}

func handlePollsPost(w http.ResponseWriter, r *http.Request) {
	fmt.Println(w, r)
}

func handlePollsDelete(w http.ResponseWriter, r *http.Request) {
	fmt.Println(w, r)
}
