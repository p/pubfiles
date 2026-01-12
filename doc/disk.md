# Disk Info

## Format To 4096 Block Size

Also removes NetApp parity data, if present.

    sg_format -F -P 0 -v --fmtpinfo=0 -s 4096 /dev/X

## Enable Write Back Cache

    sdparm --set=WCE /dev/sdX

## Read Grown Defect List

    sginfo -d /dev/sdX

## Read Drive Log

    sg_logs -A /dev/sdX

This should include information about failed and reallocated sectors
identified by background scans, but this seems to be either not available
in all drives or most drives do not locate bad sectors in this way.

## Remove SED (Self-Encrypting Drive) Encryption

    sedutil-cli --yesIreallywanttoERASEALLmydatausingthePSID PSID /dev/sdX

## Initialize Self-Encrypting Drive

(To prevent ransomware from doing it)

    sedutil-cli --initialSetup PASSWORD /dev/sdX

## Rewrite dead sectors

    for x in $(for lba in `smartctl -x /dev/sdX |grep Require.Write |awk '{print $3}' `; do  dec=`echo "ibase=16; $(echo $lba |tr a-z A-Z)" | bc`; echo $dec; done); do sg_write_verify -I 4096 -l $x /dev/sdX; done

## Change LUKS label

    cryptsetup config /dev/sdX --label YOURLABEL

## Check Seagate Hard Drive Usage

FARM metrics:
https://www.gadget-style.ru/102148-seagate-exos-hdd-power-on-hours-farm-test-guide/

## File System Fragmentation

    e2freefrag

## Disk Queue Depth

    iostat -x

## sk,asc,ascq in SMART background test error log

https://en.wikipedia.org/wiki/Key_Code_Qualifier

## File System Selection

https://linuxvox.com/blog/storing-accessing-up-to-10-million-files-in-linux/

XFS: read up on allocsize option

## SMART Attributes

https://www.backblaze.com/blog/making-sense-of-ssd-smart-stats/

https://github.com/Seagate/openSeaChest/wiki/Drive-Health-and-SMART
