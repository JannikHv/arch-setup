PACKAGES := `cat package.lst`
BIN_DIR := "/usr/local/bin"

all: yay base vim
	sudo cp -f tools/autoremove.sh $(BIN_DIR)/autoremove
	sudo cp -f tools/blurlock.sh   $(BIN_DIR)/blurlock
	sudo cp -f tools/jtk.sh        $(BIN_DIR)/jtk
	sudo cp -f tools/sasswatch.sh  $(BIN_DIR)/sasswatch

	cp -f config/bashrc ~/.bashrc
	sudo cp -f config/bashrc /etc/bash.bashrc
	sudo cp -f config/bashrc /root/.bashrc

	mkdir -p ~/.config
	cp -f config/mimeapps.list ~/.config/mimeapps.list

base:
	yay -S --noconfirm --needed $(PACKAGES)

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

yay:
	sudo pacman -S --noconfirm --needed git

	git clone https://aur.archlinux.org/yay.git

	cd yay && yes | makepkg -sir

	rm -rf yay