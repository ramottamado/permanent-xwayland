# permanent-xwayland

## Why?

On latest GNOME Shell, XWayland process will be spawned on-demand when first X11 program is started. There's a little delay and sometimes the window is buggy. This utility calls XWayland API to spawn XWayland process if no XWayland process available. Combined with user systemd unit to call this process on GNOME startup or startup script to call this process, XWayland can be initialized on startup.

## Build Requirements

```
pkg-config
libX11-devel
```

## Build & Install

```sh
make && make install

# Optional, install systemd unit files for autostart
make install-systemd
systemctl --user daemon-reload
systemctl --user enable permanent-xwayland
```
