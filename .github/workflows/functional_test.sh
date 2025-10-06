#!/bin/sh

# SPDX-FileCopyrightText: Alexander Popov <alex.popov@linux.com>
# SPDX-License-Identifier: GPL-3.0-only

set -x
set -e

git status
git show -s


echo ">>>>> no files for autodetection <<<<<"
sudo mv $FILE2 /tmp/back_conf
coverage run -a --branch bin/kernel-hardening-checker -a && exit 1
sudo mv /tmp/back_conf /$FILE2
export PATH=/nonexistent && coverage run -a --branch bin/kernel-hardening-checker -a && exit 1


echo "The end of the functional tests"
