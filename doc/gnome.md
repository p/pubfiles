## Disable Wayland

## GDM3

Change user's window manager:
https://unix.stackexchange.com/questions/317591/gdm3-change-default-wm-from-gnome-to-i3
(but edit `Session` instead of `XSession`).

E.g.

    [User]
    Session=openbox

There is also `~/.dmrc` advertised (https://help.gnome.org/admin/gdm/stable/configuration.html.en)
but this has not worked for me.
