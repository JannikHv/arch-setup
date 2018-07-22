DEPS = vim vim-nerdtree vim-runtime

install: check
	mkdir -p ~/.vim/colors
	sudo mkdir -p /usr/share/vim/vim80/syntax

	cp -rfT config/colors ~/.vim/colors/
	cp -f   config/vimrc  ~/.vimrc

	sudo cp -f config/syntax/c.vim /usr/share/vim/vim80/syntax

check:
	sudo pacman -S --noconfirm --needed $(DEPS)
