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
	git
	java-latest-openjdk
	kdenlive
	krita
	micro
	mpv
	mupdf
	ncdu
	neofetch
	nmap
	obs-studio
	powertop
	python3-pip
	rclone
	steam
"

# DNF-Package to remove (includes Gnome and KDE Plasma stuff)
dnf_remove_packages="
	akregator
	cheese
	dragon
	gnome-boxes
	gnome-contacts
	gnome-maps
	gnome-tour
	gnome-weather
	elisa-player
	libreoffice-*
	kaddressbook
	kamaso
	kmahjongg
	kmines
	kmail
	kpat
	kolourpaint
	konversation
	korganizer
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

# Alias
alias="
	# Custom Alias\n
	alias dur='sudo dnf upgrade --refresh -y && flatpak upgrade -y && flatpak remove --unused'\n
	alias mergepdf='mutool merge ./*.pdf'\n
"

exited_with_errors=false
check_error() {
    # Check the exit code
    if [ $? -ne 0 ]; then
        exited_with_errors=true
    fi
} 

# Enable Flathub repository
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
check_error

# Configure DNF
echo "max_parallel_downloads=20" >> /etc/dnf/dnf.conf

# Install DNF mirrors
dnf install -y $dnf_mirrors
check_error

# VSCode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
check_error

# Enable/Disable/Add repositories
dnf config-manager --set-enabled rpmfusion-nonfree-steam
check_error
dnf config-manager --disable google-chrome
check_error
sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
check_error
dnf copr disable phracek/PyCharm
check_error

# Remove unwanted packages
dnf remove -y $dnf_remove_packages
check_error

# Upgrade currently installed packages
dnf upgrade --refresh -y
check_error

# Install DNF packages
dnf install -y $dnf_packages
check_error

# Install flatpak packages
flatpak install -y $flatpak_packages
check_error

# Install official 7zip binary
curl https://raw.githubusercontent.com/MrMinemeet/Install7zz/main/install.sh | sudo bash
check_error

# Install NVM
sudo -u $SUDO_USER bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash'
check_error

# Install JetBrains Toolbox
wget -O - "https://data.services.jetbrains.com/products/download?platform=linux&code=TBA" | tar -xz -C /tmp/
/tmp/jetbrains*/jetbrains-toolbox
rm -r /tmp/jetbrains*

# Install Rust Toolchain via RustUp
sudo -u $SUDO_USER bash -c 'wget -qO- https://sh.rustup.rs | sh -s -- -y'
check_error

# Add alias to .bashrc
echo -e $alias >> "/home/$SUDO_USER/.bashrc"

# Info for user
echo ""
echo "Installation finished."
echo "Please reboot your system to apply all changes."


if [ $exited_with_errors = true ]; then
	# Set color to red, write info, then reset color
	echo -e "\e[31mOError(s) occured during the installation process. Please check the output for more information.\e[0m"
fi