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

check:
	yaourt -S --noconfirm --needed $(PKGS)
