all: build

build: miniupnpc

# dont forget to install python-all-dev

deb: /usr/share/pyshared/stdeb build
	(python setup.py --command-packages=stdeb.command bdist_deb)
	(cd miniupnpc; python setup.py --command-packages=stdeb.command bdist_deb)

/usr/share/pyshared/stdeb:
	(sudo apt-get install python-stdeb)

ideb:
	(sudo dpkg -i deb_dist/*.deb)
	(sudo dpkg -i miniupnpc/deb_dist/*.deb)

.PHONY: miniupnpc

miniupnpc:
	(make -C miniupnpc)
	(make -C miniupnpc pythonmodule)

.PHONY: rpm

rpm: /usr/bin/rpmbuild build
	(python setup.py bdist_rpm --dist-dir=rpm)
	(cd miniupnpc; python setup.py bdist_rpm --dist-dir=rpm)

irpm:
	(sudo rpm -i rpm/*.noarch.rpm)
	(sudo rpm -i rpm/*.noarch.rpm)

/usr/bin/rpmbuild:
	(sudo yum install -y rpmdevtools)
