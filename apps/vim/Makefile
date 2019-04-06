DEPS = vim vim-nerdtree vim-runtime

install: check
	sudo rm -rf ~/.vim ~/.vimrc
	sudo rm -rf /root/.vimrc /root/.vim

	mkdir ~/.vim
	sudo mkdir /root/.vim

	sudo mkdir -p /usr/share/vim/vim80/syntax

	cp -r config/colors ~/.vim/colors
	sudo cp -r config/colors /root/.vim/colors

	cp -f config/vimrc  ~/.vimrc
	sudo cp -f config/vimrc /root/.vimrc

	sudo cp -f config/syntax/c.vim /usr/share/vim/vim80/syntax

check:
	sudo pacman -S --noconfirm --needed $(DEPS)
