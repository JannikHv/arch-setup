PKGS = `cat package.lst`

all:
	sudo pacman -Sy --noconfirm --needed $(PKGS)

	sudo cp -f config/httpd.conf /etc/httpd/conf/httpd.conf
	sudo cp -f config/phpmyadmin.conf /etc/httpd/conf/extra/phpmyadmin.conf
