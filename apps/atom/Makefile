DEPS = atom

ATOM_INSTALL = minimap language-javascript-jsx markdown-preview-plus language-meson remote-ftp pigments
ATOM_DISABLE = wrap-guide

install: check
	mkdir -p ~/.atom
	cp -f config/keymap.cson ~/.atom/
	cp -f config/styles.less ~/.atom/
	cp -f config/config.cson ~/.atom/

check:
	sudo pacman -S --noconfirm --needed $(DEPS)
	apm install $(ATOM_INSTALL)
	apm disable $(ATOM_DISABLE)
