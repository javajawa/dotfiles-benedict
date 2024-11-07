#!/usr/bin/make -f

.PHONY=build clean

PACKAGE_DATA=.package

DATA_FILES=$(shell cat .package/manifest)
CHANGELOG=usr/share/doc/dotfiles-benedict/changelog.Debian.gz
TARGETS=$(CHANGELOG) $(DATA_FILES) owners manifest

build: $(TARGETS)

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
	-find ./home ./usr -depth -delete
