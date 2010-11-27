all:

deb: /usr/share/pyshared/stdeb
	python setup.py --command-packages=stdeb.command bdist_deb

/usr/share/pyshared/stdeb:
	(sudo apt-get install python-stdeb)

rpm: /usr/bin/rpmbuild
	(./setup.py bdist --format=rpm --dist-dir=rpm)

/usr/bin/rpmbuild:
	(sudo yum install -y rpmdevtools)
