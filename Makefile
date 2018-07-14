GOFLAGS=
BLDDIR=build

APPS = scraper api web reciver

.PHONY: $(APPS)
all: $(APPS)

$(APPS): %: $(BLDDIR)/%

$(BLDDIR)/scraper: $(wildcard scraper/*.go)
$(BLDDIR)/api: $(wildcard api/*.go)
$(BLDDIR)/web: $(wildcard web/*.go)
$(BLDDIR)/reciver: $(wildcard reciver/*.go)

$(BLDDIR)/% : 
	mkdir -p $(dir $@)
	go build ${GOFLAGS} -o $@ ./$*

.PHONY: clean
clean:
	rm -rf $(BLDDIR)
