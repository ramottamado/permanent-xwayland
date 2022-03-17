NAME = spawn-xwayland
CC ?= gcc
SRC_EXT = c
SRC_PATH = src
SRC_SYSTEMD = systemd
SERVICE_EXT = service
LIBS = x11
CFLAGS = -Wall -Wextra -O2
LDFLAGS =
DESTDIR = target
SYSTEMD_PREFIX = $$HOME/.config/systemd/user
PREFIX = $$HOME/.local
SHELL = /bin/bash

# Install
INSTALL = install
INSTALL_PROGRAM = $(INSTALL) -m 755
INSTALL_SYSTEMD = $(INSTALL) -m 644

ifneq ($(LIBS),)
	CFLAGS += $(shell pkg-config --cflags $(LIBS))
	LDFLAGS += $(shell pkg-config --libs $(LIBS))
endif

OBJECT = $(SRC_PATH)/$(NAME).$(SRC_EXT)
SYSTEMD_OBJECT = $(SRC_SYSTEMD)/$(NAME).$(SERVICE_EXT)

all: $(NAME)

.PHONY: install

install:
	@echo "Installing $(NAME) to $(PREFIX)/bin/$(NAME)"
	@$(INSTALL_PROGRAM) $(DESTDIR)/$(NAME) $(PREFIX)/bin/$(NAME)

.PHONY: uninstall

uninstall:
	@echo "Removing $(PREFIX)/bin/$(NAME)"
	@$(RM) $(PREFIX)/bin/$(NAME)

.PHONY: systemd

systemd: $(NAME).$(SERVICE_EXT)

.PHONY: install-systemd

install-systemd: systemd
	@echo "Installing $(NAME).$(SERVICE_EXT) to $(SYSTEMD_PREFIX)/$(NAME).$(SERVICE_EXT)"
	@$(INSTALL_SYSTEMD) $(DESTDIR)/$(NAME).$(SERVICE_EXT) $(SYSTEMD_PREFIX)/$(NAME).$(SERVICE_EXT)

.PHONY: uninstall-systemd

uninstall-systemd:
	@echo "Removing $(SYSTEMD_PREFIX)/$(NAME).$(SERVICE_EXT)"
	@$(RM) $(SYSTEMD_PREFIX)/$(NAME).$(SERVICE_EXT)

.PHONY: clean

clean:
	@echo "Deleting $(NAME) output"
	@$(RM) -f $(DESTDIR)/$(NAME)
	@echo "Deleting $(NAME).$(SERVICE_EXT) output"
	@$(RM) -f $(DESTDIR)/$(NAME).$(SERVICE_EXT)
	@echo "Deleting target"
	@$(RM) -rf $(DESTDIR)

$(NAME): $(OBJECT)
	mkdir -p $(DESTDIR)
	$(CC) $(CFLAGS) $< $(LDFLAGS) -o $(DESTDIR)/$@

$(NAME).$(SERVICE_EXT): $(SYSTEMD_OBJECT)
	mkdir -p $(DESTDIR)
	sed "s~^ExecStart=~ExecStart=$(PREFIX)/bin/$(NAME)~" $< >$(DESTDIR)/$@

