ROOT	= ""
PREFIX	= $(ROOT)/usr
LIBDIR	= $(PREFIX)/local/lib/bash-5.1.16

define install
	mkdir -p $(LIBDIR)
	install -m 755 ./lib/bash-5.1.16/*.sh $(LIBDIR)
	install -m 755 ./src/requiresh.sh $(PREFIX)/bin/requiresh
endef

define uninstall
	rm -rf $(LIBDIR)/check.sh $(LIBDIR)/color.sh $(LIBDIR)/os.sh $(LIBDIR)/userinterface.sh $(PREFIX)/bin/requiresh
	rmdir --ignore-fail-on-non-empty $(LIBDIR)
endef

install:
	@$(install)
	@echo "\tinstalled."

uninstall:
	@$(uninstall)
	@echo "\tuninstalled."

reinstall:
	@$(uninstall)
	@$(install)
	@echo "\treinstalled."