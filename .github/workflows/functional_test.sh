#!/bin/sh

# SPDX-FileCopyrightText: Alexander Popov <alex.popov@linux.com>
# SPDX-License-Identifier: GPL-3.0-only

set -x
set -e

git status
git show -s

echo "Beginning of the functional tests"


echo ">>>>> test the autodetection mode <<<<<"
cat /proc/cmdline
cat /proc/version
ls -l /boot
ls -l /proc/c*
FILE1=/proc/config.gz
FILE2=/boot/config-`uname -r`
if [ ! -f "$FILE1" ] ; then
    echo "$FILE1 does not exist"
    if [ ! -f "$FILE2" ] ; then
        echo "$FILE2 does not exist, create it"
        cp kernel_hardening_checker/config_files/distros/Arch_x86_64.config "$FILE2"
    fi
fi
ls -l /boot
coverage run -a --branch bin/kernel-hardening-checker -a
coverage run -a --branch bin/kernel-hardening-checker -a -m verbose
coverage run -a --branch bin/kernel-hardening-checker -a -m json
coverage run -a --branch bin/kernel-hardening-checker -a -m show_ok
coverage run -a --branch bin/kernel-hardening-checker -a -m show_fail

echo ">>>>> check the example kconfig files, cmdline, and sysctl <<<<<"
echo "root=/dev/sda l1tf=off mds=full mitigations=off randomize_kstack_offset=on retbleed=0 iommu.passthrough=0 hey hey"  > ./cmdline_example
cat ./cmdline_example
CONFIG_DIR=`find . -name config_files`
SYSCTL_EXAMPLE=$CONFIG_DIR/distros/example_sysctls.txt
KCONFIGS=`find $CONFIG_DIR -type f | grep -e "\.config" -e "\.gz"`
COUNT=0
for C in $KCONFIGS
do
        COUNT=$(expr $COUNT + 1)
        echo "\n>>>>> checking kconfig number $COUNT <<<<<"
        coverage run -a --branch bin/kernel-hardening-checker -c $C
        coverage run -a --branch bin/kernel-hardening-checker -c $C -l ./cmdline_example
        coverage run -a --branch bin/kernel-hardening-checker -c $C -s $SYSCTL_EXAMPLE
        coverage run -a --branch bin/kernel-hardening-checker -c $C -l ./cmdline_example -s $SYSCTL_EXAMPLE
        coverage run -a --branch bin/kernel-hardening-checker -c $C -l ./cmdline_example -s $SYSCTL_EXAMPLE -m verbose > /dev/null
        coverage run -a --branch bin/kernel-hardening-checker -c $C -l ./cmdline_example -s $SYSCTL_EXAMPLE -m json > /dev/null
        coverage run -a --branch bin/kernel-hardening-checker -c $C -l ./cmdline_example -s $SYSCTL_EXAMPLE -m show_ok > /dev/null
        coverage run -a --branch bin/kernel-hardening-checker -c $C -l ./cmdline_example -s $SYSCTL_EXAMPLE -m show_fail > /dev/null
done
echo "\n>>>>> have checked $COUNT kconfigs <<<<<"



echo ">>>>> no files for autodetection <<<<<"
sudo mv $FILE2 /tmp/back_conf
coverage run -a --branch bin/kernel-hardening-checker -a && exit 1
sudo mv /tmp/back_conf /$FILE2
export PATH=/nonexistent && coverage run -a --branch bin/kernel-hardening-checker -a && exit 1


echo "The end of the functional tests"
