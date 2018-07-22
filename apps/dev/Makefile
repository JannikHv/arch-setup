PKGS = `cat package.lst`

all: check
	sudo cp -f config/httpd.conf         /etc/httpd/conf/
	sudo cp -f config/httpd-default.conf /etc/httpd/conf/extra/
	sudo cp -f config/phpmyadmin.conf    /etc/httpd/conf/extra/
	sudo cp -f config/php.ini            /etc/php/

check:
	yaourt -S --noconfirm --needed $(PKGS)
