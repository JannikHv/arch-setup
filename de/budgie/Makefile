PACKAGES := `cat package.lst`

all: check icon-theme

check:
	yay -S --noconfirm --needed $(PACKAGES)

icon-theme:
	sudo pacman -S --noconfirm --needed git

	sudo rm -rf /tmp/pocillo /usr/share/icons/Pocillo
	git clone https://github.com/UbuntuBudgie/pocillo /tmp/pocillo
	sudo mv /tmp/pocillo/Pocillo /usr/share/icons/
	rm -rf /tmp/pocillo