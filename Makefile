.PHONY: all
all: imgs build

.PHONY: imgs
imgs:
	@$(MAKE) -C docs/imgs

.PHONY: build
build:
	@$(MAKE) -C build

.PHONY: clean
clean:
	@$(MAKE) -C docs/imgs clean
	@$(MAKE) -C build clean
