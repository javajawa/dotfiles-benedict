#!/usr/bin/make -f

.PHONY=build clean

PACKAGE_DATA=.package

CONTROL_FILES=debian/control debian/preinst
DATA_FILES=$(shell cat .package/manifest)
CHANGELOG=usr/share/doc/dotfiles-benedict/changelog.Debian.gz
TARGETS=$(CHANGELOG) $(CONTROL_FILES) $(DATA_FILES) owners manifest

build: $(TARGETS)

debian/%: $(PACKAGE_DATA)/%
	mkdir -vp "$(dir $@)"
	cp "$<" "$@"

$(CHANGELOG): $(PACKAGE_DATA)/changelog
	mkdir -vp "$(dir $@)"
	gzip "$<" -c >"$@"

home/benedict/%: %
	mkdir -vp "$(dir $@)"
	cp "$<" "$@"

%: $(PACKAGE_DATA)/%
	gzip "$<" -c >"$@"

manifest: $(DATA_FILES)
	find ./home ./usr -mindepth 1 ! -name .gitkeep >"$@"

clean:
	rm -rvf $(TARGETS)
	-find ./home -depth -delete
	-rmdir --parents "$(dir $(CHANGELOG))" "debian"
