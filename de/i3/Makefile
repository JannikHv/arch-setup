PKGS = `cat package.lst`

all: check
	rm -rf ~/.config/i3/
	sudo mkdir -p /etc/xdg/termite

	sudo cp -f config/i3blocks-bw.conf /etc/i3blocks.conf
	sudo cp -f config/termite-config   /etc/xdg/termite/config

	cp -f      config/xinitrc    ~/.xinitrc
	cp -f      config/Xresources ~/.Xresources
	cp -rfT    config/i3         ~/.config/i3

	cd ~/.config/i3/modules && make

check:
	yaourt -S --noconfirm --needed $(PKGS)
