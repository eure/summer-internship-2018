run:
	go run server.go

deps:
	which dep || go get -u github.com/golang/dep/cmd/dep
	dep ensure