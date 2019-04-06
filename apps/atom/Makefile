DEPS = atom

ATOM_INSTALL = minimap language-javascript-jsx markdown-preview-plus language-meson remote-ftp pigments tab-control
ATOM_DISABLE = wrap-guide

all:
	mkdir -p ~/.atom
	cp -f config/keymap.cson ~/.atom/
	cp -f config/styles.less ~/.atom/
	cp -f config/config.cson ~/.atom/

	sudo pacman -S --noconfirm --needed $(DEPS)

	apm install $(ATOM_INSTALL)

	read -p "Start atom..."

	apm disable $(ATOM_DISABLE)
