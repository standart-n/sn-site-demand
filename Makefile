TPL=smarty
DATE=$(shell date +%I:%M%p)
CHECK=\033[32m✔\033[39m
HR=\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#


#
# BUILD DOCS
#

def: all

all: folders client finish

client: js css layout indexhtml

js: client-js main-js lmd

css: client-css all-css

folders: folders-public folders-tpl

indexhtml:
	@rm -f ./index.html
	@jade --pretty ./layout/${TPL}/index.jade -O ./

lmd:
	@echo "\n lmd... \n"
	@lmd build dev

layout:
	@rm -R ./tpl/templates/
	@mkdir -p ./tpl/templates/
	@touch ./tpl/templates/.gitignore
	@jade --pretty ./layout/${TPL}/ -O ./tpl/templates

client-js:
	@coffee -cbjvp ./client/sn*.coffee > ./public/js/client/sn.js
	@uglifyjs ./public/js/client/sn.js -nc > ./public/js/client/sn.min.js

main-js:
	@coffee -cbjvp ./script/main*.coffee > ./public/js/client/main.js
	@uglifyjs ./public/js/client/main.js -nc > ./public/js/client/main.min.js



client-css:
	@recess --compile ./less/sn.less > ./public/css/sn.css
	@recess --compress ./less/sn.less > ./public/css/sn.min.css

all-css:
	@cat ./public/css/*.min.css > ./style/style.css




folders-tpl:
	@mkdir -p ./tpl/cache
	@mkdir -p ./tpl/configs
	@mkdir -p ./tpl/templates
	@mkdir -p ./tpl/templates_c

folders-public:
	@mkdir -p ./public/assets
	@mkdir -p ./public/img
	@mkdir -p ./public/css
	@mkdir -p ./public/materials
	@mkdir -p ./public/files
	@mkdir -p ./public/js/client
	@mkdir -p ./public/js/controls
	@mkdir -p ./public/js/routes
	@mkdir -p ./public/js/tpl
	
finish:
	@echo "\nSuccessfully built at ${DATE}."




#
# RUN JSHINT & QUNIT TESTS IN PHANTOMJS
#

#.PHONY: docs watch gh-pages
