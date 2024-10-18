#!/bin/bash

remove=false
if [[ "$1" == "-r" ]]; then
    remove=true #remove installed kconfigs (debug purposes)
fi


if ! [ -d "kconfigs" ]; then
    git clone --branch gh-pages https://github.com/oracle/kconfigs
fi

for dir in kconfigs/out/*/; do
    config_file="${dir}config"
    echo "Checking directory: $dir"
    echo "Config file path: $config_file"
    

    cleaned_name=$(echo "$dir" | tr -d "\"'")
    refactored_name=$(echo ${cleaned_name// /_})
    cleaned_name_2=$(basename "$refactored_name")
    target="kernel_hardening_checker/config_files/distros/${cleaned_name_2}.config"
    if [[ "$remove" == true ]]; then
        echo "Cleaning up: ${target}"
        rm "${target}"
    else
        echo "Moving to: ${target}"
        cp "$config_file" "${target}"
    fi

done


#Alpine Linux:
wget -O kernel_hardening_checker/config_files/distros/Alpinelinux_lts_x86-64.config https://git.alpinelinux.org/aports/plain/main/linux-lts/lts.x86_64.config
wget -O kernel_hardening_checker/config_files/distros/Alpinelinux_lts_aarch64.config https://git.alpinelinux.org/aports/plain/main/linux-lts/lts.aarch64.config
#Amazon Linux 2:
#Dead link, can't find direct one
#http://52.45.193.166/mirrors/http/amazonlinux.us-east-1.amazonaws.com/amazon_linux_2/?C=M;O=D
#Clear Linux OS:
wget -O kernel_hardening_checker/config_files/distros/Clearlinux_x86-64.config https://raw.githubusercontent.com/clearlinux-pkgs/linux/master/config
wget -O kernel_hardening_checker/config_files/distros/Clearlinux_x86-64.cmdline https://raw.githubusercontent.com/clearlinux-pkgs/linux/master/cmdline
#OpenSUSE:
wget -O kernel_hardening_checker/config_files/distros/OpenSUSE_x86-64.config https://github.com/openSUSE/kernel-source/blob/master/config/x86_64/default
wget -O kernel_hardening_checker/config_files/distros/OpenSUSE_aarch64.config https://github.com/openSUSE/kernel-source/blob/master/config/arm64/default
#SUSE Linux Enterprise (SLE):
wget -O kernel_hardening_checker/config_files/distros/SLE-15-SP7_x86-64.config https://github.com/openSUSE/kernel-source/blob/SLE15-SP7/config/x86_64/default
wget -O kernel_hardening_checker/config_files/distros/SLE-15-SP7_aarch64.config https://github.com/openSUSE/kernel-source/blob/SLE15-SP7/config/arm64/default
#Pentoo:
#Dead_link, could not be found
#https://raw.githubusercontent.com/pentoo/pentoo-livecd/master/livecd/amd64/kernel/config-5.5.5
#CLIP OS:
#last update 4 years ago, seems dead
#https://docs.clip-os.org/clipos/kernel.html#configuration
#https://github.com/clipos/src_platform_config-linux-hardware
#https://github.com/clipos/products_clipos/blob/master/efiboot/configure.d/95_dracut.sh
#NixOS:
#Unsopported in this script
#run contrib/get-nix-kconfig.py from nix-shell to get the kernel configs
#CBL-Mariner:
#Moved to azurelinux
#https://github.com/microsoft/CBL-Mariner/blob/1.0/SPECS/kernel/config
wget -O kernel_hardening_checker/config_files/distros/Azurelinux_x86_64.config https://raw.githubusercontent.com/microsoft/azurelinux/refs/heads/1.0/SPECS/kernel/config
if [[ "$remove" == true ]]; then #debug
    rm kernel_hardening_checker/config_files/distros/Alpinelinux_*
    rm kernel_hardening_checker/config_files/distros/Clearlinux_*
    rm kernel_hardening_checker/config_files/distros/OpenSUSE_*
    rm kernel_hardening_checker/config_files/distros/SLE-15-SP7_*
    rm kernel_hardening_checker/config_files/distros/Azurelinux_*
fi

rm -rf kconfigs