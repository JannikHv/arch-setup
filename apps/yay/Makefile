DEPS = git

install: check clean
	git clone https://aur.archlinux.org/yay.git

	cd yay && yes | makepkg -sir

check:
	sudo pacman -S --noconfirm --needed $(DEPS)

clean:
	rm -rf package-query yay
