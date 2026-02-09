## Disable Middle-Click Paste

disable middle click paste:
https://askubuntu.com/questions/4507/how-do-i-disable-middle-mouse-button-click-paste
https://unix.stackexchange.com/questions/24330/how-can-i-turn-off-middle-mouse-button-paste-functionality-in-all-programs
https://github.com/milaq/XMousePasteBlock

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

Doing this in "normally" appears to be impossible.

There is a kernel parameter to scan SCSI devices "synchronously":

https://docs.kernel.org/scsi/scsi-parameters.html

```
scsi_mod.scan=sync
```

I don't understand what this does exactly because I still get:

```
[    0.954722] mpt2sas_cm0: sending port enable !!
[    0.955520] mpt2sas_cm0: hba_port entry: 00000000041815a3, port: 255 is added to hba_port list
[    0.957519] mpt2sas_cm0: host_add: handle(0x0001), sas_addr(0x5003005700dbf999), phys(8)
[    0.958316] mpt2sas_cm0: handle(0x9) sas_address(0x5000cca2423785e5) port_type(0x1)
[    0.958563] mpt2sas_cm0: handle(0xb) sas_address(0x5000cca2558594d9) port_type(0x1)
[    0.958794] mpt2sas_cm0: handle(0xc) sas_address(0x5000cca24249be29) port_type(0x1)
[    0.959024] mpt2sas_cm0: handle(0xa) sas_address(0x5000cca25584e7e1) port_type(0x1)
[    0.970221] mpt2sas_cm0: port enable: SUCCESS
[    0.971261] scsi 0:0:0:0: SSP: handle(0x000a), sas_addr(0x5000cca25584e7e1), phy(3), device_name(0x5000cca25584e7e3)
[    0.974389]  end_device-0:0: add: handle(0x000a), sas_addr(0x5000cca25584e7e1)
[    0.975424] scsi 0:0:1:0: SSP: handle(0x0009), sas_addr(0x5000cca2423785e5), phy(0), device_name(0x5000cca2423785e7)
[    0.979657]  end_device-0:1: add: handle(0x0009), sas_addr(0x5000cca2423785e5)
[    0.980593] scsi 0:0:2:0: SSP: handle(0x000b), sas_addr(0x5000cca2558594d9), phy(1), device_name(0x5000cca2558594db)
[    0.984257]  end_device-0:2: add: handle(0x000b), sas_addr(0x5000cca2558594d9)
[    0.985087] scsi 0:0:3:0: SSP: handle(0x000c), sas_addr(0x5000cca24249be29), phy(2), device_name(0x5000cca24249be2b)
[    0.989246]  end_device-0:3: add: handle(0x000c), sas_addr(0x5000cca24249be29)
[    1.116607] ata2: SATA link down (SStatus 4 SControl 300)
[    1.116636] ata3: SATA link down (SStatus 4 SControl 300)
[    1.116662] ata4: SATA link down (SStatus 4 SControl 300)
[    1.116689] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.117037] ata1.00: ACPI cmd f5/00:00:00:00:00:e0(SECURITY FREEZE LOCK) filtered out
[    1.117046] ata1.00: ACPI cmd b1/c1:00:00:00:00:e0(DEVICE CONFIGURATION OVERLAY) filtered out
[    1.117052] ata1.00: ATA-9: SanDisk SDSA6GM-016G-1006, U221006, max UDMA/133
[    1.117056] ata1.00: 31277232 sectors, multi 1: LBA48 NCQ (depth 32)
[    1.118556] ata1.00: Features: Dev-Sleep DIPM
[    1.119577] ata1.00: ACPI cmd f5/00:00:00:00:00:e0(SECURITY FREEZE LOCK) filtered out
[    1.119587] ata1.00: ACPI cmd b1/c1:00:00:00:00:e0(DEVICE CONFIGURATION OVERLAY) filtered out
[    1.120712] ata1.00: configured for UDMA/133
[    1.153181] sd 1:0:0:0: [sdd] 31277232 512-byte logical blocks: (16.0 GB/14.9 GiB)
[    1.153199] sd 1:0:0:0: [sdd] Write Protect is off
[    1.153202] sd 1:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[    1.153221] sd 1:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.153256] sd 1:0:0:0: [sdd] Preferred minimum I/O size 512 bytes
[    1.153421] sd 0:0:0:0: [sda] 1465130646 4096-byte logical blocks: (6.00 TB/5.46 TiB)
[    1.153426] sd 0:0:2:0: [sde] 1465130646 4096-byte logical blocks: (6.00 TB/5.46 TiB)
[    1.153450] sd 0:0:3:0: [sdb] 1465130646 4096-byte logical blocks: (6.00 TB/5.46 TiB)
[    1.153963] sd 0:0:0:0: [sda] Write Protect is off
[    1.153969] sd 0:0:0:0: [sda] Mode Sense: f7 00 10 08
[    1.154041] sd 0:0:3:0: [sdb] Write Protect is off
[    1.154045] sd 0:0:3:0: [sdb] Mode Sense: f7 00 10 08
[    1.154288] sd 0:0:1:0: [sdc] 1465130646 4096-byte logical blocks: (6.00 TB/5.46 TiB)
[    1.154649] sd 0:0:1:0: [sdc] Write Protect is off
[    1.154652] sd 0:0:1:0: [sdc] Mode Sense: f7 00 10 08
[    1.154713] sd 0:0:2:0: [sde] Write Protect is off
[    1.154719] sd 0:0:2:0: [sde] Mode Sense: f7 00 10 08
[    1.154927] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
[    1.155114] sd 0:0:3:0: [sdb] Write cache: enabled, read cache: enabled, supports DPO and FUA
[    1.155205] sd 0:0:1:0: [sdc] Write cache: enabled, read cache: enabled, supports DPO and FUA
[    1.157150] sd 0:0:2:0: [sde] Write cache: enabled, read cache: enabled, supports DPO and FUA
[    1.205955]  sdc: sdc1
[    1.206109] sd 0:0:1:0: [sdc] Attached SCSI disk
[    1.213176]  sda: sda1
[    1.213432] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.217393]  sdb: sdb1
[    1.217517] sd 0:0:3:0: [sdb] Attached SCSI disk
[    1.231907]  sdd: sdd1 sdd2 sdd3
[    1.232579] sd 1:0:0:0: [sdd] Attached SCSI disk
[    1.242586]  sde: sde1
[    1.242854] sd 0:0:2:0: [sde] Attached SCSI disk
```

What happened here:
- First disk device is `sdd` for some reason.
- The drives on SAS controller are, in port order: `sda`, `sdc`, `sde`, `sdb`.
- `scsi 0:0:0:0` got assigned to `phy(3)`.
- The SATA SSD is in the middle of my SAS HDDs.

The reason for this dumpster fire of device names, I am assuming,
is that all of the devices are probed in parallel and whichever disk responds
first gets `sda` assigned to it, and so on. And because I have two controllers
(the SATA one on the mainboard and a SAS card) those naturally also get
probed in parallel, and are probably returning the drives in parallel, which
is how the SATA SSD ends up in the middle of SAS HDDs. And, of course,
any of these drives may be missing at boot, or may go missing at any time
while the system is running (in theory, the SSD can't go anywhere because it's
the boot drive), which is why the order of devices is "arbitrary" and
must be so.

What I care more about however is that now `iostat` output puts the SSD
in the middle of HDDs, because it shows the `sdX` devices in order.
And when I operate on the drives I have to always get tripped up by `sdd`
being the boot drive and not a data drive.

Many people are asking how to fix this but nobody is getting answers.
Examples:
- https://askubuntu.com/questions/371049/how-are-dev-sda-and-dev-sdb-chosen
- https://superuser.com/questions/1608246/how-do-i-configure-which-disk-becomes-dev-sda
- https://unix.stackexchange.com/questions/498115/how-to-control-order-of-disk-devices-during-ubuntu-linux-installation
- https://unix.stackexchange.com/questions/723903/how-can-i-order-dev-sdx-block-devices-names-by-hardware-path-on-linux
- https://unix.stackexchange.com/questions/281282/how-to-prevent-sda-sdb-changes-between-boots

The non-answer which is given is "set up so-called 'persistent device names'
via udev', e.g. here:
https://wiki.debian.org/Persistent_disk_names

The problem with this non-answer is that while it is certainly possible to
boot the system by referencing labels in `fstab`, for example, this does
nothing to make the running system usable, because utilities like `iostat`
still output `sdX` devices which make no sense.

And, while it is possible, for example, to feed the "persistent block device
names" to `fdisk`, do you really want to work with this:

```
# fdisk -l /dev/disk/by-path/pci-0000:01:00.0-sas-phy3-lun-0
Disk /dev/disk/by-path/pci-0000:01:00.0-sas-phy3-lun-0: 5.46 TiB, 6001175126016 bytes, 1465130646 sectors
Disk model: HUS726060AL5211 
Units: sectors of 1 * 4096 = 4096 bytes
Sector size (logical/physical): 4096 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 131072 bytes
Disklabel type: gpt
Disk identifier: 886DE28C-7CDC-4B30-A3D7-F87565E61E44

Device                                                  Start        End    Sectors  Size Type
/dev/disk/by-path/pci-0000:01:00.0-sas-phy3-lun-0-part1   256 1465130495 1465130240  5.5T Linux temporary data
```

Now yes, it does say `phy3` in there, but I also have the `pci-0000:01:00.0`
which I don't care about and here is the kicker: on the SAS breakout cable,
the drive connectors are marked "1" through "4", and of course this
`lun3` (the fourth one, since luns are starting from 0) does not correspond
to the drive attached to the connector marked "4".
So this is just trading short nonsense name for a long nonsense name.

And tools like `smartctl` don't work with these device paths at all.
Maybe `smartctl` accepts something other than `/dev/sdX` for device path,
I really don't feel like investigating.

Interestingly, if I unload `mp3sas` and `modprobe` it back in, the drives
are named in order of their SCSI positions (which still does not match the
physical layout but at least the kernel itself now manages to order them the
same):

```
[33246.100888] mpt2sas_cm0: sending port enable !!
[33246.101669] mpt2sas_cm0: hba_port entry: 000000004a4284fa, port: 255 is added to hba_port list
[33246.104310] mpt2sas_cm0: host_add: handle(0x0001), sas_addr(0x5003005700dbf999), phys(8)
[33246.105126] mpt2sas_cm0: handle(0x9) sas_address(0x5000cca2423785e5) port_type(0x1)
[33246.105368] mpt2sas_cm0: handle(0xb) sas_address(0x5000cca2558594d9) port_type(0x1)
[33246.105606] mpt2sas_cm0: handle(0xc) sas_address(0x5000cca24249be29) port_type(0x1)
[33246.105845] mpt2sas_cm0: handle(0xa) sas_address(0x5000cca25584e7e1) port_type(0x1)
[33246.114320] mpt2sas_cm0: port enable: SUCCESS
[33246.115533] scsi 0:0:0:0: SSP: handle(0x000a), sas_addr(0x5000cca25584e7e1), phy(3), device_name(0x5000cca25584e7e3)
[33246.118875] sd 0:0:0:0: Attached scsi generic sg0 type 0
[33246.119170]  end_device-0:0: add: handle(0x000a), sas_addr(0x5000cca25584e7e1)
[33246.119324] sd 0:0:0:0: [sda] 1465130646 4096-byte logical blocks: (6.00 TB/5.46 TiB)
[33246.119868] sd 0:0:0:0: [sda] Write Protect is off
[33246.119876] sd 0:0:0:0: [sda] Mode Sense: f7 00 10 08
[33246.120334] scsi 0:0:1:0: SSP: handle(0x0009), sas_addr(0x5000cca2423785e5), phy(0), device_name(0x5000cca2423785e7)
[33246.120807] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
[33246.122883] sd 0:0:1:0: Attached scsi generic sg1 type 0
[33246.123145]  end_device-0:1: add: handle(0x0009), sas_addr(0x5000cca2423785e5)
[33246.123349] sd 0:0:1:0: [sdb] 1465130646 4096-byte logical blocks: (6.00 TB/5.46 TiB)
[33246.123717] sd 0:0:1:0: [sdb] Write Protect is off
[33246.123722] sd 0:0:1:0: [sdb] Mode Sense: f7 00 10 08
[33246.124144] scsi 0:0:2:0: SSP: handle(0x000b), sas_addr(0x5000cca2558594d9), phy(1), device_name(0x5000cca2558594db)
[33246.124275] sd 0:0:1:0: [sdb] Write cache: enabled, read cache: enabled, supports DPO and FUA
[33246.140361] sd 0:0:2:0: Attached scsi generic sg2 type 0
[33246.140808]  end_device-0:2: add: handle(0x000b), sas_addr(0x5000cca2558594d9)
[33246.141863] scsi 0:0:3:0: SSP: handle(0x000c), sas_addr(0x5000cca24249be29), phy(2), device_name(0x5000cca24249be2b)
[33246.146677] sd 0:0:3:0: Attached scsi generic sg3 type 0
[33246.146906]  end_device-0:3: add: handle(0x000c), sas_addr(0x5000cca24249be29)
[33246.147249] sd 0:0:3:0: [sde] 1465130646 4096-byte logical blocks: (6.00 TB/5.46 TiB)
[33246.148592] sd 0:0:3:0: [sde] Write Protect is off
[33246.148598] sd 0:0:3:0: [sde] Mode Sense: f7 00 10 08
[33246.149575] sd 0:0:2:0: [sdc] 1465130646 4096-byte logical blocks: (6.00 TB/5.46 TiB)
[33246.150965] sd 0:0:2:0: [sdc] Write Protect is off
[33246.150971] sd 0:0:2:0: [sdc] Mode Sense: f7 00 10 08
[33246.151297] sd 0:0:3:0: [sde] Write cache: enabled, read cache: enabled, supports DPO and FUA
[33246.153578] sd 0:0:2:0: [sdc] Write cache: enabled, read cache: enabled, supports DPO and FUA
[33246.170243]  sda: sda1
[33246.170479] sd 0:0:0:0: [sda] Attached SCSI disk
[33246.172592]  sdb: sdb1
[33246.172725] sd 0:0:1:0: [sdb] Attached SCSI disk
[33246.204537]  sde: sde1
[33246.204724] sd 0:0:3:0: [sde] Attached SCSI disk
[33246.219373]  sdc: sdc1
[33246.219533] sd 0:0:2:0: [sdc] Attached SCSI disk
```

The reporting order is still messed up but at least the end result makes a
little more sense. Of coures, I still have `sdd` in the middle of these drives,
and there's no way to fix that once the system is booted.

The best solution, then, is as follows:

1. Blacklist `mpt3sas` so that the SAS drives are not probed during boot.
This removes the race between the SATA controller and the SAS one, so you are
guaranteed to have `sda` for the SATA drive:

```
echo blacklist mpt3sas |tee /etc/modprobe.d/blacklist-mpt3sas.conf
update-initramfs -u
```

The blacklist configuration must be in initramfs, hence the call to update it.

2. Load `mpt3sas` once the system comes up:

```
modprobe mpt3sas
```

Nice fast parallel boot eh?

By the way, FreeBSD had disk devices in BIOS order at least between 4.x
through 5.x when I was using it, and it had different naming schemes for
ATA and SCSI devices, so you'd get for example `ad4` for your only ATA drive
but it would stay as `ad4` the entire time, and if you move it to another
connector on the mainboard you could get it to be before or after another
drive. SCSI drives were named `daX`, I never had any while I ran FreeBSD.
Linux dumps both types of drives into `sdX` namespace, which is also
justified in some way, and maybe some people want all of their drives to
be just be called "disk" (or, maybe, `C:`?) but why is there no setting to
separate ATA from SCSI disks and have something like a probe delay for every
controller/port/drive to have sensible device names once the system is up?
I have seen references to server boot times already being excessive but
personally my machines usually stay up for months at a time thus the difference
in boot time between 15 seconds and a minute really is insignificant.

## X11 & Gnome

https://www.reddit.com/r/archlinux/comments/1nr7xz3/how_to_restore_x11_with_gnome_49/

## Memory Limiting

`ulimit -m` does not work because it's ignored by the kernel:
https://linuxvox.com/blog/why-ulimit-can-t-limit-resident-memory-successfully-and-how/
and
https://unix.stackexchange.com/questions/129587/does-ulimit-m-not-work-on-modern-linux.

cgroups is the only solution that works.
Documentation for cgroups seems to be atrocious though so the following
commands are cobbled together from various internet sources.
The instructions below are for cgroups v2. It seems that there are at least
some API changes between v1 and v2, and given the general lack of documentation,
what the API changes are exactly is probably impossible to figure out.

### Enable Controller

Find out which controllers you have enabled:

```
# cat /sys/fs/cgroup/cgroup.controllers                          
cpuset memory
```

If `memory` is not present, enable it by adding to the kernel command line
(and reboot):

```
cgroup_enable=memory
```

To enable multiple controllers, add multiple arguments:

```
cgroup_enable=memory cgroup_enable=cpuset
```

Then, the cgroup filesystem needs to be mounted:

```
mount -t cgroup2 none /sys/fs/cgroup
```

Then, memory limits must be enabled:

```
echo '+memory' | sudo tee /sys/fs/cgroup/cgroup.subtree_control
```

Then, create a group:

```
mkdir /sys/fs/cgroup/limited
```

Set its memory limit:

```
echo 100M |tee /sys/fs/cgroup/limited/memory.max       
```

To apply the memory limit to a running process:

```
echo $PID > /sys/fs/cgroup/limited/cgroup.procs
```

To launch a process in a cgroup:

```
cgexec -g memory:limited program ...
```

Here the `memory:` part is required for some reason, and the command
requires root privileges.

`cgexec` produces nonsensical error messages and uses an environment variable
to output diagnostics:

```
CGROUP_LOGLEVEL=INFO cgexec -g memory:limited echo hi

Warning: cannot write tid 15498 to /sys/fs/cgroup//limited/cgroup.procs:Permission denied
Warning: cgroup_attach_task_pid failed: 50007
cgroup change of group failed
```

All of the actual issues, which are errors, are labeled "warning", they
couldn't even get that right.

### Launch in cgroup

In order to put a process into a cgroup, the user trying to do so must have
write access to the existing cgroup (if there isn't one explicitly set, it's
"root") and the new cgroup. Meaning, if we want to launch a process into a
cgroup as a non-root user, the shell of that user must be placed into the
right cgroup by root, as described above.

Once the shell is in a cgroup, all processed launched from it (including
those that change the user via `sudo`) stay in that cgroup. Meaning, there
sort of is no need to change cgroup as non-root user.

However, it's important to verify that memory restriction is active, by
querying the current cgroup and its limits:

```
% cat /proc/self/cgroup 
12:misc:/
11:rdma:/
10:pids:/
9:hugetlb:/
8:net_prio:/
7:perf_event:/
6:net_cls:/
5:freezer:/
4:devices:/
3:blkio:/
2:cpuacct:/
1:cpu:/
0::/limited
```

The important line here is the last one, for the controller "0" (whatever
that means).

A process not in any cgroup (technically, in the root one) wlll show:

```
# cat /proc/self/cgroup 
12:misc:/
11:rdma:/
10:pids:/
9:hugetlb:/
8:net_prio:/
7:perf_event:/
6:net_cls:/
5:freezer:/
4:devices:/
3:blkio:/
2:cpuacct:/
1:cpu:/
0::/
```

And check limits:

```
% cat /sys/fs/cgroup/limited/memory.max
104857600
% cat /sys/fs/cgroup/limited/memory.swap.max 
104857600
```

References:
- https://askubuntu.com/questions/1406329/how-to-run-cgexec-without-sudo-as-current-user-on-ubuntu-22-04-with-cgroups-v2
- https://unix.stackexchange.com/questions/725112/using-cgroups-v2-without-root

### What Memory Limit?

I did a simple test of the memory limit by setting it to 100 MB and reading
1 GB from `/dev/zero` in a Ruby process. Imagine my surprise when the program
successfully ran to completion!

What happens here is once the "memory" limit (of 100 MB in this case)
is reached, the kernel simply allocates pages from swap. So my program that
was supposed to be limited to 100 MB of memory allocated 100 GB of RAM and
1 GB of swap and ran just fine. Cool.

References for this behavior:
- https://unix.stackexchange.com/questions/799261/how-does-the-linux-kernel-decide-whether-to-deny-memory-allocation-or-invoke-the/799271#799271
- https://unix.stackexchange.com/questions/727101/why-do-processes-on-linux-crash-if-they-use-a-lot-of-memory-yet-still-less-than?rq=1

And, curiously, 
https://www.kernel.org/doc/html/latest/admin-guide/cgroup-v2.html
says:

> While not completely water-tight, all major memory usages by a given cgroup are tracked so that the total memory consumption can be accounted and controlled to a reasonable extent.

Except "controlled" apparently means the data is simply moved to swap.

In other words, the "memory" limit is the same thing as an RSS limit except
the kernel is actively helping programs evade it (and the programs can get
killed at any time when they page memory in from wap). So now instead of simply
limiting RSS with all of the caveats, we have the same exact
no-actually-memory-limit with cgroups with a ton of setup steps and awkwardness.
Hmm.

I checked the process death behavior by running the following command
which reads 1 GB from /dev/zero - this passes the 100 MB memory limit:

```
% ruby -e "a=File.open('/dev/zero').read(1_000_000_000); puts a.length"              
1000000000
```

But, trying to uppercase this giant string kills the process:

```
% ruby -e "a=File.open('/dev/zero').read(1_000_000_000); a.upcase; puts a.length"
zsh: killed     ruby -e 
```

By the way, I noticed that the memory was being allocated from swap by
looking at `top` output. On an otherwise idle system, while the test program
was running and its memory consumption (RSS) was reported as around 100 MB,
the global swap used increased to 1 GB.

To fix this, we also need to limit swap:

```
echo 100M |tee /sys/fs/cgroup/limited/memory.swap.max       
```

Do not make the mistake of writing to `swap.max` instead of `memory.max` -
this produces no errors but also does not do anything.

https://www.kernel.org/doc/html/latest/admin-guide/cgroup-v2.html
implies that cgroups v1 had a function to limit memory and swap usage
together:

> The main argument for a combined memory+swap facility in the original cgroup design

### Delegation

https://www.man7.org/linux/man-pages/man7/cgroups.7.html

       Note: one consequence of these delegation containment rules is
       that the unprivileged delegatee can't place the first process into
       the delegated subtree; instead, the delegater must place the first
       process (a process owned by the delegatee) into the delegated
       subtree.

It is still not possible to launch a new process in a cgroups as a non-root user.

Also:
https://unix.stackexchange.com/questions/754605/how-to-add-pid-inside-cgroup-procs-with-non-root-privileges-in-cgroup-v2-in-ubun

### Background

- https://marc.info/?l=linux-kernel&m=113951956111878
- http://web.archive.org/web/20231116005246/https://bugzilla.kernel.org/show_bug.cgi?id=5167
- https://github.com/parke/rlimit_rss
- https://chrisdown.name/2019/07/18/linux-memory-management-at-scale.html
- https://superuser.com/questions/1502287/what-is-the-history-behind-ulimit-m-rlimit-rss-not-working

It is possible to limit RSS, as the experimental module is showing.
The issue with doing it seems to be (at least) that pages in swap do not
count as RSS, thus paging a program into memory from swap could get it
killed due to exceeding RSS. (This is not necessarily a showstopper -
if the amount of swap in a system is much less than the amount of RAM,
disregarding how much of a program is in swap is still workable and will
produce meaningful behavior.)

The other option was to implement a limit on, let's say, "RSS+swap", but
there was no label for such a thing, and I guess developers did not want
to apply "RSS" label to "RSS+swap", and just gave up on implementing anything
instead.

References:
- https://linuxvox.com/blog/why-ulimit-can-t-limit-resident-memory-successfully-and-how/
- https://unix.stackexchange.com/questions/44985/limit-memory-usage-for-a-single-linux-process
- https://unix.stackexchange.com/questions/725112/using-cgroups-v2-without-root
- https://askubuntu.com/questions/1406329/how-to-run-cgexec-without-sudo-as-current-user-on-ubuntu-22-04-with-cgroups-v2

Alternative instructions - for cgroups v1?
https://unix.stackexchange.com/questions/44985/limit-memory-usage-for-a-single-linux-process

```
cgcreate -g memory:myGroup
echo 500M > /sys/fs/cgroup/memory/myGroup/memory.limit_in_bytes
echo 5G > /sys/fs/cgroup/memory/myGroup/memory.memsw.limit_in_bytes
```

Comments say this is not working.

### Delete cgroup

```
cgdelete controllers:path
```

https://www.kernel.org/doc/html/latest/admin-guide/cgroup-v2.html
says the directory in sysfs can be removed.

## Dropping Privileges

https://blog.habets.se/2022/03/Dropping-privileges.html

## sshfs

Automatically reconnect:
https://serverfault.com/questions/6709/sshfs-mount-that-survives-disconnect?rq=1

-o reconnect,ServerAliveInterval=15,ServerAliveCountMax=3
