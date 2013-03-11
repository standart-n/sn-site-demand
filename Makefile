
DATE=$(shell date +%I:%M%p)
CHECK=\033[32m✔\033[39m
HR=\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#


#
# BUILD DOCS
#

def: all

all: folders client server finish

client: coffee-js js css img jade-tpl ajaxloader

server: app controls-js routes-js

sn: sn-css main-css coffee-js sn-js lmd

bs: bs-css main-css bs-js bs-img lmd

js: coffee-js sn-js bs-js lmd

css: sn-css bs-css main-css

img: bs-img

check-js:
	@echo "\nrunning JSHint on javascript...\n"
	@mkdir -p ./js-tmp/
	@cp ./public/js/client/sn.js ./js-tmp/sn.js
	@cp ./public/js/client/main.js ./js-tmp/main.js
	@jshint ./js-tmp/*.js --config ./.jshintrc
	@rm -R ./js-tmp/

	@echo "\nbs: running JSHint on javascript...\n"
	@jshint ./bootstrap/js/*.js --config ./bootstrap/js/.jshintrc

ajaxloader:
	@echo "\najaxloader...\n"
	@cat ./tpl/templates/index.html > ./index.html

lmd:
	@echo "\nlmd...\n"
	@lmd build dev

jade-tpl:
	@echo "\njade...\n"
	@rm -R ./tpl/templates/
	@mkdir -p ./tpl/templates/
	@touch ./tpl/templates/.gitignore
	@jade --pretty ./jade/smarty/ -O ./tpl/templates

coffee-js:
	@echo "\ncoffee...\n"
	@coffee -cbjvp ./client/sn*.coffee > ./public/js/client/sn.js

main-css:
	@cat ./public/css/bootstrap.css ./public/css/bootstrap-responsive.css ./public/css/sn.css > ./public/css/style.css
	@cat ./public/css/bootstrap.min.css ./public/css/bootstrap-responsive.min.css ./public/css/sn.min.css > ./public/css/style.min.css

sn-css:
	@echo "\nsn: compiling LESS with Recess\n"
	@recess --compile ./less/sn.less > ./public/css/sn.css
	@recess --compress ./less/sn.less > ./public/css/sn.min.css

sn-js:
	@echo "\nsn: compiling and minifying javascript...\n"
	@coffee -cbjvp ./script/main*.coffee > ./public/js/client/main.js

	@echo "\nsn: uglifyjs...\n"
	@uglifyjs ./public/js/client/sn.js -nc > ./public/js/client/sn.min.js
	@uglifyjs ./public/js/client/main.js -nc > ./public/js/client/main.min.js

bs-img:
	@cp ./bootstrap/img/* ./public/img/

bs-css:
	@echo "\nbs: compiling LESS with Recess...\n"
	@recess --compile ./bootstrap/less/bootstrap.less > ./public/css/bootstrap.css
	@recess --compress ./bootstrap/less/bootstrap.less > ./public/css/bootstrap.min.css
	@recess --compile ./bootstrap/less/responsive.less > ./public/css/bootstrap-responsive.css
	@recess --compress ./bootstrap/less/responsive.less > ./public/css/bootstrap-responsive.min.css

bs-js:
	@echo "bs: compiling and minifying javascript...\n"
	@cat ./bootstrap/js/bootstrap-*.js  > ./public/js/client/bootstrap.js
	@uglifyjs ./public/js/client/bootstrap.js -nc > ./public/js/client/bootstrap.min.tmp.js

	@echo "/**\n* bootstrap.js v2.2.2 by @fat & @mdo\n* Copyright 2012 Twitter, Inc.\n* http://www.apache.org/licenses/LICENSE-2.0.txt\n*/" > ./bootstrap/copyright
	@cat ./bootstrap/copyright ./public/js/client/bootstrap.min.tmp.js > ./public/js/client/bootstrap.min.js
	@rm ./bootstrap/copyright ./public/js/client/bootstrap.min.tmp.js



controls-js:
	@echo "\ncontrols...\n"
	@rm -fR ./public/js/controls
	@mkdir -p ./public/js/controls
	@coffee -o ./public/js/controls -cb ./node_controls/

routes-js:
	@echo "\nroutes...\n"
	@rm -fR ./public/js/routes
	@mkdir -p ./public/js/routes
	@coffee -o ./public/js/routes -cb ./node_routes/

app:
	@echo "\napp...\n"
	@coffee -cbjvp ./script/app*.coffee > ./app

start:
	@echo "forever start -o ./log/out.log -e ./log/err.log app"
	@forever start -o ./log/out.log -e ./log/err.log app

stop:
	@echo "stop app"
	@forever stop app


folders:
	@mkdir -p ./tpl/cache
	@mkdir -p ./tpl/configs
	@mkdir -p ./tpl/templates
	@mkdir -p ./tpl/templates_c
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
