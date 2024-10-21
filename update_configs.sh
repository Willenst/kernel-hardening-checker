#!/bin/bash

remove=false
if [[ "$1" == "-r" ]]; then #option to remove all created configs
    remove=true
fi

if ! git clone --branch gh-pages https://github.com/oracle/kconfigs; then
    echo "Failed to clone kconfigs. Make sure the directory does not exist or empty."
    exit 1
fi

for dir in kconfigs/out/*/; do
    config_file="${dir}config"
    echo "Extracting from directory: $dir"
    echo "Config file path: $config_file"

    cleaning_stage_1=$(echo "$dir" | tr -d "\"'") #clean unneded quotes
    cleaning_stage_2=$(echo ${cleaning_stage_1// /_}) #change " " to the "_"
    filename=$(basename "$cleaning_stage_2") #extract file name
    target="kernel_hardening_checker/config_files/distros/${filename}.config"

    if [[ "$remove" == true ]]; then
        echo "Cleaning up: ${target}"
        rm "${target}"
    else
        echo "Moving to: ${target}"
        cp "$config_file" "${target}"
    fi

done

rm -rf kconfigs #clean unneded folder

if [[ "$remove" == true ]]; then #debug
    rm kernel_hardening_checker/config_files/distros/Alpinelinux_*
    rm kernel_hardening_checker/config_files/distros/Clearlinux_*
    rm kernel_hardening_checker/config_files/distros/OpenSUSE_*
    rm kernel_hardening_checker/config_files/distros/SLE-15-SP7_*
    rm kernel_hardening_checker/config_files/distros/Azure_linux_*
    exit 1
fi

wget -O kernel_hardening_checker/config_files/distros/Alpinelinux_lts_x86-64.config https://git.alpinelinux.org/aports/plain/main/linux-lts/lts.x86_64.config
wget -O kernel_hardening_checker/config_files/distros/Alpinelinux_lts_aarch64.config https://git.alpinelinux.org/aports/plain/main/linux-lts/lts.aarch64.config
wget -O kernel_hardening_checker/config_files/distros/Clearlinux_x86-64.config https://raw.githubusercontent.com/clearlinux-pkgs/linux/master/config
wget -O kernel_hardening_checker/config_files/distros/Clearlinux_x86-64.cmdline https://raw.githubusercontent.com/clearlinux-pkgs/linux/master/cmdline
wget -O kernel_hardening_checker/config_files/distros/OpenSUSE_x86-64.config https://github.com/openSUSE/kernel-source/blob/master/config/x86_64/default
wget -O kernel_hardening_checker/config_files/distros/OpenSUSE_aarch64.config https://github.com/openSUSE/kernel-source/blob/master/config/arm64/default
wget -O kernel_hardening_checker/config_files/distros/SLE-15-SP7_x86-64.config https://github.com/openSUSE/kernel-source/blob/SLE15-SP7/config/x86_64/default
wget -O kernel_hardening_checker/config_files/distros/SLE-15-SP7_aarch64.config https://github.com/openSUSE/kernel-source/blob/SLE15-SP7/config/arm64/default
wget -O kernel_hardening_checker/config_files/distros/Azure_linux_x86_64.config https://raw.githubusercontent.com/microsoft/azurelinux/refs/heads/1.0/SPECS/kernel/config