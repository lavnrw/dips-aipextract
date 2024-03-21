.PHONY: all
all:

.PHONY: install
install: aipextract
	@install -Dm 755 $^ /usr/local/bin/

.PHONY: uninstall
uninstall:
	@rm /usr/local/bin/aipextract
