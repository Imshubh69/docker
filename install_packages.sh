#!/bin/bash

# Uncomment community [multilib] repository
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

# Update
pacman -Syyu --needed --noconfirm 2>&1 | grep -v "warning: could not get file information"

# Install Basic Packages
pacman -Sy --needed --noconfirm \
	sudo nano git curl wget rsync aria2 rclone \
        python3 python-pip zip unzip cmake \
	make neofetch speedtest-cli inetutils cpio \
	jdk-openjdk lzip dpkg openssl ccache repo \
	libelf base-devel openssh lz4 jq go ncurses \
	bison flex ninja uboot-tools z3 glibc dpkg \
	multilib-devel bc htop python-setuptools   \
	util-linux man pv patchelf

# More Packages
pacman -Sy --needed --noconfirm \
	tmate tmux screen mlocate unace unrar p7zip \
	sharutils uudeview arj cabextract file-roller \
	dtc brotli axel gawk detox clang gcc gcc-libs \
	flatpak

# Symlinks for python an
ln -sf /usr/bin/pip3.10 /usr/bin/pip3
ln -sf /usr/bin/pip3.10 /usr/bin/pip
ln -sf /usr/bin/python3.10 /usr/bin/python3
ln -sf /usr/bin/python3.10 /usr/bin/python

# python3 and pip3 version
python3 --version; pip3 --version

# Install Some pip3 packages
pip3 install \
	twrpdtgen telegram-send backports.lzma docopt \
	extract-dtb protobuf pycrypto docopt zstandard \
	setuptools

# pip3 git packages
pip3 install \
	git+https://github.com/samloader/samloader.git

# Create a non-root user for AUR
useradd -m -G wheel -s /bin/bash testuser
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# AUR Packages
sudo -u testuser yay -S --needed --noconfirm \
	rename

# Setup the Android Build Environment
cd /tmp/scripts
sudo chmod -R a+rwx .
sudo -u testuser bash ./aosp-build-env.sh
cd -

