SERVER_COFFEE_FILES = app.coffee $(wildcard server/*.coffee)
CLIENT_COFFEE_FILES = $(wildcard client/*/*.coffee)
COFFEE_FILES = $(SERVER_COFFEE_FILES) $(CLIENT_COFFEE_FILES)
SERVER_JS_FILES = $(patsubst %.coffee, %.js, $(SERVER_COFFEE_FILES))
CLIENT_JS_FILES = $(patsubst %.coffee, %.js, $(CLIENT_COFFEE_FILES))
JS_FILES = $(SERVER_JS_FILES) $(CLIENT_JS_FILES)
JADE_FILES = $(wildcard client/*/*.jade)
HTML_FILES = $(patsubst %.jade, %.html, $(JADE_FILES))
LESS_FILES = $(wildcard client/*/*.less)
CSS_FILES = $(patsubst %.less, %.css, $(LESS_FILES))
COMPONENTS = component.json $(wildcard client/*/component.js)
TEMPLATES = $(HTML_FILES:.html=.js)

all: uglify

uglify: build/build.min.js

build/build.min.js: build
	uglifyjs -c -o $@ build/build.js

build: components docs $(CSS_FILES) $(JS_FILES) $(TEMPLATES) $(HTML_FILES)
	@component build

components: $(COMPONENTS)
	@component install

docs: $(COFFEE_FILES) README.md
	docco-husky $^

$(JS_FILES): %.js: %.coffee
	coffee -c $<

$(CSS_FILES): %.css: %.less
	lessc $< $@

$(HTML_FILES): %.html: %.jade
	jade $<

%.js: %.html
	@component convert $<

watch:
	jade -w $(JADE_FILES)

clean:
	rm -fr docs build components $(TEMPLATES) $(CSS_FILES) $(HTML_FILES) $(JS_FILES)

.PHONY: clean watch
