.PHONY: build test

VERSION=0.1
ARCH=all
DESCRIPTION="Drucken mit CUPS an der HSR via E-Mail"
URL="https://github.com/raphiz/hsr-email-print"
MAINTAINER="Raphael Zimmermann <raphael.zimmermann@hsr.ch>"

default: buildimage

buildimage:
	docker build -t raphiz/hsr-email-print .

package:
	mkdir -p dist
	-rm dist/hsr-email-print_$(VERSION)_$(ARCH).deb
	docker run -it --rm --name hsr-email-print -v $(shell pwd):/src/ raphiz/hsr-email-print fpm -s "dir" -t "deb" -v $(VERSION) -n "hsr-email-print" -x Makefile -x Dockerfile  -x .git --prefix /opt/hsr-email-print --after-install setup.sh -x dist --before-remove uninstall.sh --license LGPL -a $(ARCH) --vendor $(MAINTAINER) -m $(MAINTAINER) --url $(URL) --description $(DESCRIPTION) .
	mv hsr-email-print_$(VERSION)_$(ARCH).deb dist/
