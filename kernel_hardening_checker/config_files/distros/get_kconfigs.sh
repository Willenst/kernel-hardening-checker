#!/bin/bash

oracle_git_url="https://raw.githubusercontent.com/oracle/kconfigs/refs/heads/gh-pages/out/"
arch_git_url="https://gitlab.archlinux.org/archlinux/packaging/packages/"

distros_from_oracle=(
    "Android 12 (5.10) aarch64"
    "Android 15 (6.6) aarch64"
    "Arch x86_64"
    "CentOS Hyperscale 9 aarch64"
    "CentOS Hyperscale 9 x86_64"
    "Debian 10 Buster x86_64"
    "Debian 13 Trixie aarch64"
    "Debian 13 Trixie x86_64"
    "Fedora 39 Core aarch64"
    "Fedora 39 Core x86_64"
    "Fedora 41 Core aarch64"
    "Fedora 41 Core x86_64"
    "Oracle Linux 7 (UEK 4) x86_64"
    "Oracle Linux 9 (UEK-NEXT) aarch64"
    "Oracle Linux 9 (UEK-NEXT) x86_64"
    "Ubuntu 20.04 LTS Focal x86_64"
    "Ubuntu 24.04 LTS Noble aarch64"
    "Ubuntu 24.04 LTS Noble x86_64"
)

for distro in "${distros_from_oracle[@]}"; do
    filename=$(echo ${distro// /_}) # Replace spaces with underscores
    wget -O "${filename}.config" "${oracle_git_url}${distro}/config" # Fetch kconfig
done

# Fetch some other kconfigs
wget -O Clearlinux_x86_64.config https://raw.githubusercontent.com/clearlinux-pkgs/linux/master/config
wget -O Clearlinux_x86_64.cmdline https://raw.githubusercontent.com/clearlinux-pkgs/linux/master/cmdline
wget -O OpenSUSE_x86_64.config https://raw.githubusercontent.com/openSUSE/kernel-source/refs/heads/master/config/x86_64/default
wget -O OpenSUSE_aarch64.config https://raw.githubusercontent.com/openSUSE/kernel-source/refs/heads/master/config/arm64/default
wget -O SLE-15-SP7_x86_64.config https://raw.githubusercontent.com/openSUSE/kernel-source/refs/heads/SLE15-SP7/config/x86_64/default
wget -O SLE-15-SP7_aarch64.config https://raw.githubusercontent.com/openSUSE/kernel-source/refs/heads/SLE15-SP7/config/arm64/default
wget -O Azure_linux_x86_64.config https://raw.githubusercontent.com/microsoft/azurelinux/refs/heads/1.0/SPECS/kernel/config
wget -O Archlinux-hardened_x86_64.config ${arch_git_url}linux-hardened/-/raw/main/config?ref_type=heads
