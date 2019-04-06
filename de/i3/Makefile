PKGS = `cat package.lst`

all: check
	rm -rf ~/.config/i3/
	mkdir -p ~/.config/i3
	sudo mkdir -p /etc/xdg/termite

	sudo cp -f config/i3blocks-bw.conf /etc/i3blocks.conf
	sudo cp -f config/termite-config   /etc/xdg/termite/config

	cp -f      config/xinitrc    ~/.xinitrc
	cp -f      config/Xresources ~/.Xresources
	cp -rfT    config/i3         ~/.config/i3

	sudo cp -f config/i3/scripts/mkwp.sh /usr/local/bin/mkwp
	sudo cp -f config/30-touchpad.conf /etc/X11/xorg.conf.d/30-touchpad.conf

	cd ~/.config/i3/modules && make

	systemctl --user mask pulseaudio.{service,socket}

check:
	yaourt -S --noconfirm --needed $(PKGS)
