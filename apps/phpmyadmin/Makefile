PKGS = `cat package.lst`

all:
	sudo pacman -Sy --noconfirm --needed $(PKGS)

	sudo cp -f config/httpd.conf /etc/httpd/conf/httpd.conf
	sudo cp -f config/phpmyadmin.conf /etc/httpd/conf/extra/phpmyadmin.conf 
	sudo sed -i 's/;extension=mysqli/extension=mysqli/g' /etc/php/php.ini
	sudo systemctl restart httpd

	@echo "Map 127.0.0.1 to pma in /etc/hosts"
