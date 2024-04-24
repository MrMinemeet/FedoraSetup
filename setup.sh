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
	zsh
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
	com.discordapp.Discord
	com.spotify.Client
	com.jgraph.drawio.desktop
	com.github.Eloston.UngoogledChromium
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

# Get NerdFont for zsh themes
wget -qO /tmp/CodeNewRoman.zip "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/CodeNewRoman.zip"
mkdir -p /home/$SUDO_USER/.local/share/fonts/
unzip -f -d /home/$SUDO_USER/.local/share/fonts/ /tmp/CodeNewRoman.zip -x license.txt README.md
rm /tmp/CodeNewRoman.zip

# Install Zsh additions
sudo -u $SUDO_USER sh -c "wget -qO- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh -s -- --unattended" # Makes zsh nicer
check_error
# Makes zsh even nicer
curl -s https://ohmyposh.dev/install.sh | bash -s
check_error
# Package manager for Zsh
curl -sL git.io/antigen > /usr/local/bin/antigen.zsh
check_error
# Get .zshrc from GitHub into .zshrc
curl -sL https://raw.githubusercontent.com/MrMinemeet/FedoraSetup/main/.zshrc > /home/$SUDO_USER/.zshrc
check_error
# Get aliases from GitHub into .config/aliases
curl -sL https://raw.githubusercontent.com/MrMinemeet/FedoraSetup/main/aliases > /home/$SUDO_USER/.config/aliases
check_error
# Get theme from GitHub into .config/themes/atomic.omp.json
mkdir /home/$SUDO_USER/.config/themes
curl -sL https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/atomic.omp.json > /home/$SUDO_USER/.config/themes/atomic.omp.json

chsh -s $(which zsh) $SUDO_USER # Change shell to Zsh
check_error

# Install official 7zip binary
curl https://raw.githubusercontent.com/MrMinemeet/Install7zz/main/install.sh | sudo bash
check_error

# Install JetBrains Toolbox
wget -O - "https://data.services.jetbrains.com/products/download?platform=linux&code=TBA" | tar -xz -C /tmp/
/tmp/jetbrains*/jetbrains-toolbox
rm -r /tmp/jetbrains*

# Install Rust Toolchain via RustUp
sudo -u $SUDO_USER zsh -c 'wget -qO- https://sh.rustup.rs | sh -s -- -y'
check_error

# Info for user
echo ""
echo "Installation finished."
echo "In order to make the fonts work, set 'ComicShannsMono Nerd Font Mono' in your terminal."
echo "Please reboot your system to apply all changes."

if [ $exited_with_errors = true ]; then
	# Set color to red, write info, then reset color
	echo -e "\e[31mError(s) occured during the installation process. Please check the output for more information.\e[0m"
fi