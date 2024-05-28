# FedoraSetup
Script for installing and configuring a new Fedora install to my likings.

## Used version:
* Fedora 40 Gnome
* Fedora 40 KDE

(Likely works elsewhere too, but these are the ones I use)

## Usage:
Run `curl -sL https://raw.githubusercontent.com/MrMinemeet/FedoraSetup/main/setup.sh | sudo bash` in your terminal to download and run the script.

## Packages installed:
### DNF
* [btop](https://github.com/aristocratos/btop)
* [vscode](https://code.visualstudio.com/)
* [dotnet](https://dotnet.microsoft.com/)
* [fastfetch](https://github.com/fastfetch-cli/fastfetch)
* [gcc](https://gcc.gnu.org/)
* [gh](https://cli.github.com/)
* [git](https://git-scm.com/)
* [java-latest-openjdk](https://openjdk.java.net/)
* [kdenlive](https://kdenlive.org/)
* [krita](https://krita.org/)
* [micro](https://micro-editor.github.io/)
* [mpv](https://mpv.io/)
* [mupdf](https://mupdf.com/)
* [ncdu](https://dev.yorhel.nl/ncdu)
* [nmap](https://nmap.org/)
* [obs-studio](https://obsproject.com/)
* [powertop](https://01.org/powertop)
* [python3-pip](https://pip.pypa.io/)
* [rclone](https://rclone.org/)
* [steam](https://steampowered.com/)
* [zsh](https://www.zsh.org/)

### Flatpak
* [Bitwarden](https://bitwarden.com/)
* [Cryptomator](https://cryptomator.org/)
* [Discord](https://discord.com/)
* [Drawio](https://draw.io/)
* [OnlyOffice](https://www.onlyoffice.com/)
* [Signal](https://signal.org/)
* [Standard Notes](https://standardnotes.com/)
* [Spotify](https://spotify.com/)
* [Ungoogled Chromium](https://github.com/ungoogled-software/ungoogled-chromium)

### Others
* [7zip](https://www.7-zip.org/) - (official binary)
* [Jetbrains Toolbox](https://www.jetbrains.com/toolbox-app/) - (official "installer")
* [zsh-nvm](https://github.com/lukechilds/zsh-nvm) - (zsh plugin)
* [RustUp](https://rustup.rs/) - (official install script)
* [oh-my-zsh](https://ohmyz.sh/) - (official install script)
* [oh-my-posh](https://ohmyposh.dev/) - (official install script)
* [antigen](https://antigen.sharats.me/) - (official install script)
* [atomic](https://github.com/JanDeDobbeleer/oh-my-posh/blob/main/themes/atomic.omp.json) - (oh my posh style)

## Packages removed:
* akregator
* cheese
* dragon
* gnome-boxes
* gnome-contacts
* gnome-maps
* gnome-tour
* gnome-weather
* elisa-player
* libreoffice (everything of it)
* kaddressbook
* kamaso
* kmahjongg
* kmines
* kmail
* kpat
* kolourpaint
* konversation
* korganizer
* rhythmbox
* simple-scan
* totem
* yelp

## Alias:
* `dnfs` - `dnf search`
* `dnfl` - `dnf list`
* `dnfi` - `sudo dnf install`
* `dnfr` - `sudo dnf remove`
* `dnfu` - `sudo dnf upgrade`
* `dur` - `dnfu --refresh -y && flatpak upgrade -y && flatpak remove --unused`
* `mergepdf` - `mutool merge ./*.pdf`
* `update-ohmyposh` - `curl -s https://ohmyposh.dev/install.sh | bash -s`
* `coder` - `code -r`

## Configurations:
* Install `rpmfusion` repositories and additionally enable `rpmfusion-free-steam`
* Disable `google-chrome` repository
* Disable `phracek/PyCharm` COPR repository
* Add `flathub.org` repository in addition to the default Fedora flatpak repository
* Use `zsh` as default shell
