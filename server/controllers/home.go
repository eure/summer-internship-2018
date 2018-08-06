package controllers

import "github.com/gin-gonic/gin"

func Home(c *gin.Context) {
	c.JSON(200, gin.H{
		"message": "Hello World!"})
}

func Trend(c *gin.Context) {
	t := c.Param("type")
	if t == "all" {
		t = ""
	} else {
		t = "/" + t
	}
	c.JSON(200, string(getJSON("https://github.com/trending/"+t)))
}
