.PHONY: build test

VERSION=0.1
ARCH=all
DESCRIPTION="Drucken mit CUPS an der HSR via E-Mail"
URL="https://github.com/raphiz/hsr-email-print"
MAINTAINER="Raphael Zimmermann <raphael.zimmermann@hsr.ch>"
FPM-PARAMS=-s "dir" -v $(VERSION) -n "hsr-email-print" -x Makefile -x Dockerfile -x dist -x ".git*" -x "*.sh" --prefix /opt/hsr-email-print --after-install setup.sh --before-remove uninstall.sh --license LGPL -a $(ARCH) --vendor $(MAINTAINER) -m $(MAINTAINER) --url $(URL) -d cups -d zenity -d python3 --description $(DESCRIPTION) .

default: buildimage

build_deb_image:
	docker build -t raphiz/hsr-email-print-debian docker/debian

build_rpm_image:
	docker build -t raphiz/hsr-email-print-fedora docker/fedora

buildimage: build_deb_image build_rpm_image

package_rpm:
	-mkdir -p dist
	-rm dist/hsr-email-print-$(VERSION)-1.noarch.rpm
	docker run -it --rm --name hsr-email-print-fedora -v $(shell pwd):/src/ raphiz/hsr-email-print-fedora fpm -t "rpm" $(FPM-PARAMS)
	mv hsr-email-print-$(VERSION)-1.noarch.rpm dist/

package_deb:
	-mkdir -p dist
	-rm dist/hsr-email-print_$(VERSION)_$(ARCH).deb
	docker run -it --rm --name hsr-email-print-debian -v $(shell pwd):/src/ raphiz/hsr-email-print-debian fpm -t "deb" $(FPM-PARAMS)
	mv hsr-email-print_$(VERSION)_$(ARCH).deb dist/

package: package_rpm package_deb
