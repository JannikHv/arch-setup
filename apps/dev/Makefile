all:
	@echo '$$ make [phpmyadmin / docker / mysql / atom]'

phpmyadmin:
	yay -S --noconfirm --needed php apache php-apache phpmyadmin

	sudo cp -f config/phpmyadmin/httpd.conf /etc/httpd/conf/httpd.conf
	sudo cp -f config/phpmyadmin/phpmyadmin.conf /etc/httpd/conf/extra/phpmyadmin.conf
	sudo sed -i 's/;extension=mysqli/extension=mysqli/g' /etc/php/php.ini
	sudo systemctl restart httpd

	@echo "Map 127.0.0.1 to pma in /etc/hosts"

docker:
	yay -S --noconfirm --needed docker

	sudo groupadd -f docker
	sudo usermod -aG docker ${USER}

mysql:
	yay -S --noconfirm --needed mariadb

	sudo systemctl stop mysqld

	sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

	sudo systemctl start mysqld

	mysql_secure_installation

atom:
	yay -S --noconfirm --needed atom

	mkdir -p ~/.atom

	cp -f config/atom/keymap.cson ~/.atom/
	cp -f config/atom/styles.less ~/.atom/
	cp -f config/atom/config.cson ~/.atom/

	apm install minimap pigments tab-control file-type-icons remote-ftp
	apm install language-javascript-jsx markdown-preview-plus language-meson language-docker
