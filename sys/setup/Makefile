PKGS = `cat package.lst`

BIN_DIR = "/usr/local/bin"

all: check
	sudo cp -f tools/autoremove.sh $(BIN_DIR)/autoremove
	sudo cp -f tools/blurlock.sh   $(BIN_DIR)/blurlock
	sudo cp -f tools/jtk.sh        $(BIN_DIR)/jtk
	sudo cp -f tools/sasswatch.sh  $(BIN_DIR)/sasswatch

	cp -f config/bashrc ~/.bashrc
	sudo cp -f config/bashrc /etc/bash.bashrc
	sudo cp -f config/bashrc /root/.bashrc

	mkdir -p ~/.config
	cp -f config/mimeapps.list ~/.config/mimeapps.list

check:
	yay -S --noconfirm --needed $(PKGS)
