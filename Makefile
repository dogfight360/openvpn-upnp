all:

# dont forget to install python-all-dev

deb: /usr/share/pyshared/stdeb
	(python setup.py --command-packages=stdeb.command bdist_deb)
	(cd miniupnpc; python setup.py --command-packages=stdeb.command bdist_deb)

ideb:
	(sudo dpkg -i deb_dist/*.deb)
	(sudo dpkg -i miniupnpc/deb_dist/*.deb)

.PHONY: miniupnpc

miniupnpc:
	(make -C miniupnpc pythonmodule)

/usr/share/pyshared/stdeb:
	(sudo apt-get install python-stdeb)

rpm: /usr/bin/rpmbuild
	(./setup.py bdist --format=rpm --dist-dir=rpm)

/usr/bin/rpmbuild:
	(sudo yum install -y rpmdevtools)
