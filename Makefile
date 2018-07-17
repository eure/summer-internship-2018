GOFLAGS=
BLDDIR=build

APPS = scraper api web receiver

.PHONY: $(APPS)
all: deps $(APPS)

$(APPS): %: $(BLDDIR)/%

$(BLDDIR)/scraper: $(wildcard scraper/*.go)
$(BLDDIR)/api: $(wildcard api/*.go)
$(BLDDIR)/web: $(wildcard web/*.go)
$(BLDDIR)/reciver: $(wildcard receiver/*.go)

$(BLDDIR)/% : 
	mkdir -p $(dir $@)
	go build ${GOFLAGS} -o $@ ./$*

deps:
	dep ensure

.PHONY: clean
clean:
	rm -rf ./vendor
	rm -rf $(BLDDIR)
