#!/bin/bash

# Links with raw content
links=(
    "https://raw.githubusercontent.com/oracle/kconfigs/refs/heads/gh-pages/out/Android 14 (6.1) aarch64/config"
    "https://raw.githubusercontent.com/oracle/kconfigs/refs/heads/gh-pages/out/Debian 13 Trixie aarch64/config"
    "https://raw.githubusercontent.com/oracle/kconfigs/refs/heads/gh-pages/out/Debian 13 Trixie x86_64/config"
    "https://raw.githubusercontent.com/oracle/kconfigs/refs/heads/gh-pages/out/CentOS Hyperscale 9 aarch64/config"
    "https://raw.githubusercontent.com/oracle/kconfigs/refs/heads/gh-pages/out/CentOS Hyperscale 9 x86_64/config"
    "https://raw.githubusercontent.com/oracle/kconfigs/refs/heads/gh-pages/out/Fedora 39 Core aarch64/config"
    "https://raw.githubusercontent.com/oracle/kconfigs/refs/heads/gh-pages/out/Fedora 39 Core x86_64/config"
    "https://raw.githubusercontent.com/oracle/kconfigs/refs/heads/gh-pages/out/Oracle Linux 9 (UEK-NEXT) aarch64/config"
    "https://raw.githubusercontent.com/oracle/kconfigs/refs/heads/gh-pages/out/Oracle Linux 9 (UEK-NEXT) x86_64/config"
    "https://raw.githubusercontent.com/oracle/kconfigs/refs/heads/gh-pages/out/Ubuntu 24.04 LTS Noble aarch64/config"
    "https://raw.githubusercontent.com/oracle/kconfigs/refs/heads/gh-pages/out/Ubuntu 24.04 LTS Noble x86_64/config"
    "https://raw.githubusercontent.com/oracle/kconfigs/refs/heads/gh-pages/out/Upstream Default 6.6 aarch64/config"
    "https://raw.githubusercontent.com/oracle/kconfigs/refs/heads/gh-pages/out/Upstream Default 6.6 x86_64/config"
)

# Parse 'distro' from link and create 'distro'.config file in kernel_hardening_checker/config_files/distros
for url in "${links[@]}"; do
    folder_link="${url%/*}" # Strip 'config'
    distro_name="${folder_link##*/}" # Extract distro name
    cleaning_stage_2=$(echo ${distro_name// /_}) # Replace spaces with underscores
    filename="${cleaning_stage_2}.config" # Create file name
    target="${filename}"
    wget -O "$target" "$url" # Fetch kconfig
    mv "config" "${target}" #
done

# Fetch some other kconfigs
wget -O Clearlinux_x86-64.config https://raw.githubusercontent.com/clearlinux-pkgs/linux/master/config
wget -O Clearlinux_x86-64.cmdline https://raw.githubusercontent.com/clearlinux-pkgs/linux/master/cmdline
wget -O OpenSUSE_x86-64.config https://raw.githubusercontent.com/openSUSE/kernel-source/refs/heads/master/config/x86_64/default
wget -O OpenSUSE_aarch64.config https://raw.githubusercontent.com/openSUSE/kernel-source/refs/heads/master/config/arm64/default
wget -O SLE-15-SP7_x86-64.config https://raw.githubusercontent.com/openSUSE/kernel-source/refs/heads/SLE15-SP7/config/x86_64/default
wget -O SLE-15-SP7_aarch64.config https://raw.githubusercontent.com/openSUSE/kernel-source/refs/heads/SLE15-SP7/config/x86_64/default
wget -O Azure_linux_x86_64.config https://raw.githubusercontent.com/microsoft/azurelinux/refs/heads/1.0/SPECS/kernel/config
