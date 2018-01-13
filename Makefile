#!/usr/bin/make -f

.PHONY=build

CHANGELOG=usr/share/doc/dotfiles-benedict/changelog.Debian.gz

build: $(CHANGELOG)

$(CHANGELOG): changelog
	mkdir -vp $(dir $@)
	gzip changelog -c >$@

clean:
	rm $(CHANGELOG)
	-rmdir --parents $(dir $(CHANGELOG))
