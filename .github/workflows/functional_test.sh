#!/bin/sh

# SPDX-FileCopyrightText: Alexander Popov <alex.popov@linux.com>
# SPDX-License-Identifier: GPL-3.0-only

set -x
set -e

git status
git show -s

echo "Beginning of the functional tests"

script -q -c "coverage run -a --branch bin/kernel-hardening-checker -a" /dev/null

echo "The end of the functional tests"
