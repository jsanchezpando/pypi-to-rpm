install:
	gem install fpm

build:
	./build-pypi.sh
	./build-pypi.sh python2.7
