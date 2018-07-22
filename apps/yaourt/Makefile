DEPS = git

install: check clean
	git clone https://aur.archlinux.org/package-query.git
	git clone https://aur.archlinux.org/yaourt.git

	cd package-query && yes | makepkg -sir

	cd yaourt && yes | makepkg -sir

check:
	sudo pacman -S --noconfirm --needed $(DEPS)

clean:
	rm -rf package-query yaourt
