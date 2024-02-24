#!/bin/bash

# Check if script is run as root/with sudo
if [ $(id -u) -ne 0 ]
  then echo "Please run as root!"
  exit
fi


# DNF-Repositories
dnf_mirrors="
	https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
	https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
"

# DNF-Packages
dnf_packages="
	btop
	code
	discord
	dotnet-sdk-8.0
	gcc
	gh
	java-latest-openjdk
	kdenlive
	krita
	micro
	mpv
	mupdf
	neofetch
	nmap
	python3-pip
	rclone
	steam
"

# DNF-Package to remove (includes Gnome and KDE Plasma stuff)
dnf_remove_packages="
	cheese
	gnome-boxes
	gnome-contacts
	gnome-maps
	gnome-tour
	gnome-weather
	elisa-player
	libreoffice-*
	kamaso
	kmail
	kolourpaint
	rhythmbox
	simple-scan
	totem
	yelp
"

# Flatpak-Pakages
flatpak_packages="
	com.bitwarden.desktop
	org.signal.Signal
	org.onlyoffice.desktopeditors
	org.cryptomator.Cryptomator
	md.obsidian.Obsidian
	com.spotify.Client
	com.jgraph.drawio.desktop
	com.github.Eloston.UngoogledChromium
"

# Enable Flathub repository
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Configure DNF
echo "max_parallel_downloads=20" >> /etc/dnf/dnf.conf
echo "fastestmirror=True" >> /etc/dnf/dnf.conf

# Install DNF mirrors
dnf install -y $dnf_mirrors
# VSCode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

# Enable/Disable/Add repositories
dnf config-manager --set-enabled rpmfusion-nonfree-steam
dnf config-manager --disable google-chrome
sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
dnf copr disable phracek/PyCharm

# Remove unwanted packages
dnf remove -y $dnf_remove_packages

# Upgrade currently installed packages
dnf upgrade --refresh -y

# Install DNF packages
dnf install -y $dnf_packages

# Install flatpak packages
flatpak install -y $flatpak_packages

# Install official 7zip binary
curl https://raw.githubusercontent.com/MrMinemeet/Install7zz/main/install.sh | sudo bash

# Install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Install JetBrains Toolbox
wget -O - "https://data.services.jetbrains.com/products/download?platform=linux&code=TBA" | tar -xz -C /tmp/
/tmp/jetbrains*/jetbrains-toolbox
rm -r /tmp/jetbrains*

# Install Rust Toolchain via RustUp
wget -qO- https://sh.rustup.rs | sh -s -- -y


# Get updated bash data
source "$HOME/.bashrc"

# Install NodeJS LTS
nvm install --lts