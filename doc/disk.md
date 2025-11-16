# Disk Info

## Format To 4096 Block Size

Also removes NetApp parity data, if present.

    sg_format -F -P 0 -v --fmtpinfo=0 -s 4096 /dev/X

## Enable Write Back Cache

    sdparm --set=WCE /dev/sdX

## Read Grown Defect List

    sginfo -d /dev/X

## Remove SED (Self-Encrypting Drive) Encryption

    sedutil-cli --yesIreallywanttoERASEALLmydatausingthePSID PSID /dev/sdX

## Initialize Self-Encrypting Drive

(To prevent ransomware from doing it)

    sedutil-cli --initialSetup PASSWORD /dev/sdX

## Rewrite dead sectors

    for x in $(for lba in `smartctl -x /dev/sdX |grep Require.Write |awk '{print $3}' `; do  dec=`echo "ibase=16; $(echo $lba |tr a-z A-Z)" | bc`; echo $dec; done); do sg_write_verify -I 4096 -l $x /dev/sdX; done

## Change LUKS label

    cryptsetup config /dev/sdX --label YOURLABEL
