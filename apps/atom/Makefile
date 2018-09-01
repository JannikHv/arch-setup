DEPS = atom

ATOM_INSTALL = minimap language-javascript-jsx
ATOM_DISABLE = wrap-guide

install: check
	mkdir -p ~/.atom
	cp -f config/keymap.cson ~/.atom/
	cp -f config/style.less  ~/.atom/

check:
	sudo pacman -S --noconfirm --needed $(DEPS)
	apm install $(ATOM_INSTALL)
	apm disable $(ATOM_DISABLE)
