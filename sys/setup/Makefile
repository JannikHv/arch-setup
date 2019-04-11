DEPS = yaourt

PKGS = `cat package.lst`

BIN_DIR = "/usr/local/bin"

all: check
	sudo cp -f tools/autoremove.sh $(BIN_DIR)/autoremove
	sudo cp -f tools/blurlock.sh   $(BIN_DIR)/blurlock
	sudo cp -f tools/jtk.sh        $(BIN_DIR)/jtk
	sudo cp -f tools/mkcert.sh     $(BIN_DIR)/mkcert
	sudo cp -f tools/mkcfile.py    $(BIN_DIR)/mkcfile
	sudo cp -f tools/mkcomp.py     $(BIN_DIR)/mkcomp
	sudo cp -f tools/msc.sh        $(BIN_DIR)/msc
	sudo cp -f tools/sasswatch.sh  $(BIN_DIR)/sasswatch

	cp -f config/bashrc ~/.bashrc
	sudo cp -f config/bashrc /etc/bash.bashrc
	sudo cp -f config/bashrc /root/.bashrc

	mkdir -p ~/.config
	cp -f config/mimeapps.list ~/.config/mimeapps.list

	@read -p "Enter git E-Mail: " gitemail;\
	git config --global user.email "$$gitemail" --replace-all
	@read -p "Enter git User: " gituser;\
	git config --global user.name "$$gituser" --replace-all

	git config --global format.pretty online
	git config --global credential.helper store

check:
	yaourt -S --noconfirm --needed $(PKGS)
