VERSION=$(shell perl -lne 'm|version=.(\d\.\d\.\d)|g && print $$1' setup.py)

all: build

clean: carchive

build: miniupnpc

# dont forget to install python-all-dev

deb: /usr/share/pyshared/stdeb build
	(python setup.py --command-packages=stdeb.command bdist_deb)
	(cd ../miniupnp/miniupnpc && python setup.py --command-packages=stdeb.command bdist_deb)

/usr/share/pyshared/stdeb: /usr/share/doc/python-all-dev
	(sudo apt-get install python-stdeb)

/usr/share/doc/python-all-dev:
	(sudo apt-get install python-all-dev)

ideb:
	(sudo dpkg -i deb_dist/*.deb)
	(make -C ../miniupnp/miniupnpc ideb)

.PHONY: miniupnpc

miniupnpc:
	(make -C ../miniupnp/miniupnpc)
	(make -C ../miniupnp/miniupnpc pythonmodule)

.PHONY: rpm

rpm: /usr/bin/rpmbuild build
	(mkdir -p rpm && python setup.py bdist_rpm --dist-dir=rpm)
	(cd ../miniupnp/miniupnpc && mkdir -p rpm && python setup.py bdist_rpm --dist-dir=rpm)

irpm:
	(sudo rpm -U --force rpm/*.noarch.rpm)
	(sudo rpm -U --force ../miniupnp/miniupnpc/rpm/*.i686.rpm)

/usr/bin/rpmbuild:
	(sudo yum install -y rpmdevtools)

archive:
	mkdir openvpn-upnp-${VERSION}
	cp -r src openvpn-upnp-${VERSION}/
	cp Makefile setup.py openvpn-upnp-${VERSION}/
	mkdir openvpn-upnp-${VERSION}/miniupnpc
	cp -r miniupnpc/* openvpn-upnp-${VERSION}/miniupnpc/
	tar -czvf openvpn-upnp-${VERSION}.tgz openvpn-upnp-${VERSION}/

carchive:
	rm -rf openvpn-upnp-${VERSION}
