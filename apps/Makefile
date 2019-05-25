all:
	@echo '$$ make <Options>'
	@echo ''
	@echo 'Options:'
	@echo '  - yay'
	@echo '  - git'
	@echo '  - python'
	@echo '  - scss'
	@echo '  - phpmyadmin'
	@echo '  - docker'
	@echo '  - mysql'
	@echo '  - atom'
	@echo '  - vim'

yay:
	sudo pacman -S --noconfirm --needed git

	git clone https://aur.archlinux.org/yay.git

	cd yay && yes | makepkg -sir

	rm -rf yay

git:
	yay -S --noconfirm --needed git

	@read -p "Enter git E-Mail: " gitemail;\
	git config --global user.email "$$gitemail" --replace-all

	@read -p "Enter git User: " gituser;\
	git config --global user.name "$$gituser" --replace-all

	git config --global format.pretty oneline
	git config --global credential.helper store

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

	apm install minimap pigments tab-control file-type-icons remote-ftp markdown-preview-plus
	apm install language-javascript-jsx language-meson language-docker language-nginx

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
