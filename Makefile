
SRC = $(wildcard client/*/*.js) $(wildcard client/*/*.css)
HTML = $(wildcard client/*/*.html)
COMPONENTS = component.json $(wildcard client/*/component.js)
TEMPLATES = $(HTML:.html=.js)

build: components $(SRC) $(TEMPLATES)
	@component build

components: $(COMPONENTS)
	@component install

%.js: %.html
	@component convert $<

clean:
	rm -fr build components $(TEMPLATES)

.PHONY: clean
