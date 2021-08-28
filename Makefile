NAME = SCUTIWEN
TARGET = src/SCUTIWEN.jl

.PHONY: build test

all: build test

build:
	julia deps/build.jl

test:
	julia $(TARGET)

install:
	install -Dm755 "$(TARGET)" "$(DESTDIR)/usr/bin/$(NAME)"
	install -Dm644 "LICENSE" "$(DESTDIR)/usr/share/licenses/$(NAME)/LICENSE"

uninstall:
	rm -rfv "$(DESTDIR)/usr/bin/$(NAME)" "$(DESTDIR)/usr/share/licenses/$(NAME)"
