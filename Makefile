define install:

endef

define uninstall:

endef

install:
	$(install)
	@echo ""

uninstall:
	$(uninstall)
	@echo ""

reinstall:
	$(uninstall)
	$(install)
	@echo ""