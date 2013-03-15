TPL=smarty
DATE=$(shell date +%I:%M%p)
CHECK=\033[32m✔\033[39m
HR=\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#


#
# BUILD DOCS
#

def: all

all: folders client server finish

client: js css layout indexhtml

server: node-app node-controls node-routes

js: client-js main-js lmd

css: client-css all-css

bootstrap: bs-img bs-css bs-js

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
	@cat ./public/css/*.min.css > ./public/assets/style.css



node-app:
	@echo "\n app... \n"
	@coffee -cbjvp ./script/app*.coffee > ./app

node-controls:
	@echo "\n controls... \n"
	@rm -fR ./public/js/controls
	@mkdir -p ./public/js/controls
	@coffee -o ./public/js/controls -cb ./node_controls/

node-routes:
	@echo "\n routes... \n"
	@rm -fR ./public/js/routes
	@mkdir -p ./public/js/routes
	@coffee -o ./public/js/routes -cb ./node_routes/



start:
	@echo "forever start -o ./log/out.log -e ./log/err.log app"
	@forever start -o ./log/out.log -e ./log/err.log app

stop:
	@echo "stop app"
	@forever stop app


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




bs-img:
	@cp ./bootstrap/img/* ./public/img/

bs-css:
	@recess --compile ./bootstrap/less/bootstrap.less > ./public/css/bootstrap.css
	@recess --compress ./bootstrap/less/bootstrap.less > ./public/css/bootstrap.min.css
	@recess --compile ./bootstrap/less/responsive.less > ./public/css/bootstrap-responsive.css
	@recess --compress ./bootstrap/less/responsive.less > ./public/css/bootstrap-responsive.min.css

bs-js:
	@cat ./bootstrap/js/bootstrap-*.js  > ./public/js/client/bootstrap.js
	@uglifyjs ./public/js/client/bootstrap.js -nc > ./public/js/client/bootstrap.min.tmp.js

	@echo "/**\n* bootstrap.js v2.2.2 by @fat & @mdo\n* Copyright 2012 Twitter, Inc.\n* http://www.apache.org/licenses/LICENSE-2.0.txt\n*/" > ./bootstrap/copyright
	@cat ./bootstrap/copyright ./public/js/client/bootstrap.min.tmp.js > ./public/js/client/bootstrap.min.js
	@rm ./bootstrap/copyright ./public/js/client/bootstrap.min.tmp.js



#
# RUN JSHINT & QUNIT TESTS IN PHANTOMJS
#

#.PHONY: docs watch gh-pages
