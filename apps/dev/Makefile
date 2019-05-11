all:
	@echo '$$ make [python / scss / phpmyadmin / docker / mysql / atom / vim]'

python:
	yay -S --noconfirm --needed python python-virtualenv

scss:
	yay -S --noconfirm --needed sassc

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

vim:
	yay -S --noconfirm --needed vim vim-nerdtree vim-runtime

	sudo rm -rf ~/.vim ~/.vimrc
	sudo rm -rf /root/.vimrc /root/.vim

	mkdir ~/.vim
	sudo mkdir /root/.vim

	sudo mkdir -p /usr/share/vim/vim80/syntax

	cp -r config/vim/colors ~/.vim/colors
	sudo cp -r config/vim/colors /root/.vim/colors

	cp -f config/vim/vimrc  ~/.vimrc
	sudo cp -f config/vim/vimrc /root/.vimrc

	sudo cp -f config/vim/syntax/c.vim /usr/share/vim/vim80/syntax
