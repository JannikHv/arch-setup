DEPS = atom

ATOM_INSTALL = minimap language-javascript-jsx markdown-preview-plus language-meson remote-ftp pigments tab-control

all:
	mkdir -p ~/.atom
	cp -f config/keymap.cson ~/.atom/
	cp -f config/styles.less ~/.atom/
	cp -f config/config.cson ~/.atom/

	sudo pacman -S --noconfirm --needed $(DEPS)

	apm install $(ATOM_INSTALL)
