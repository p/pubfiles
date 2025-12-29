## Disable IPv6

https://linuxconfig.org/how-to-disable-ipv6-on-linux

## Common Commands

### Hold Debian Package

    apt-mark hold <package>

## SATA Hot Plug

```
echo "0 0 0" >/sys/class/scsi_host/host<n>/scan
```

https://serverfault.com/questions/5336/how-do-i-make-linux-recognize-a-new-sata-dev-sda-drive-i-hot-swapped-in-without

## Elan Trackpoint Issues

https://askubuntu.com/questions/1250841/ubuntu-20-04-elantech-touchpad-not-working
https://www.sumarsono.com/manjaro-fixing-elan-touchpad-issues/

## AppArmor

If a program has AppArmor configuration, and is launched with a custom
configuration file, it's likely to be accessing paths outside of the supplied
AppArmor configuration which will trigger AppArmor warnings in logs.

Solution is either to create a new AppArmor profile for the custom
configuration or disable AppArmor for the program completely, which
can be done by creating (e.g. touching, does not have to be a symlink)
file in `/etc/apparmor.d/disable` matching the name of the profile in
`/etc/apparmor.d`:

    touch /etc/apparmor.d/disable/program-name

Reference: https://wiki.ubuntu.com/DebuggingApparmor

## Apt modernize sources

https://daniel-lange.com/archives/192-Make-apt-shut-up-about-modernize-sources-in-Trixie.html



Alternatively add

```
# Keep apt shut about preferring the "deb822" sources file format
APT::Get::Update::SourceListWarnings "false";
```

to /etc/apt/apt.conf.d/10quellsourceformatwarnings .

Format difference:
https://connectemoi.eu/posts/deb822/

## Order SCSI Disks

https://docs.kernel.org/scsi/scsi-parameters.html

```
scsi_mod.scan=sync
```

See also:
https://wiki.debian.org/Persistent_disk_names
