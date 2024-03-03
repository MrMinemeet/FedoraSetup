# FedoraSetup
Script for installing and configuring a new Fedora install to my likings.

## Used version:
* Fedora 39 Gnome
* Fedora 39 KDE

(Likely works elsewhere too, but these are the ones I use)

## Packages installed:
### DNF
* [btop](https://github.com/aristocratos/btop)
* [vscode](https://code.visualstudio.com/)
* [discord](https://discord.com/)
* [dotnet](https://dotnet.microsoft.com/)
* [gcc](https://gcc.gnu.org/)
* [gh](https://cli.github.com/)
* [git](https://git-scm.com/)
* [java-latest-openjdk](https://openjdk.java.net/)
* [kdenlive](https://kdenlive.org/)
* [krita](https://krita.org/)
* [micro](https://micro-editor.github.io/)
* [mpv](https://mpv.io/)
* [mupdf](https://mupdf.com/)
* [neofetch](https://github.com/dylanaraps/neofetch)
* [nmap](https://nmap.org/)
* [obs-studio](https://obsproject.com/)
* [python3-pip](https://pip.pypa.io/)
* [rclone](https://rclone.org/)
* [steam](https://steampowered.com/)

### Flatpak
* [Bitwarden](https://bitwarden.com/)
* [Cryptomator](https://cryptomator.org/)
* [Drawio](https://draw.io/)
* [Obsidian](https://obsidian.md/)
* [OnlyOffice](https://www.onlyoffice.com/)
* [Signal](https://signal.org/)
* [Spotify](https://spotify.com/)
* [Ungoogled Chromium](https://github.com/ungoogled-software/ungoogled-chromium)

### Others
* [7zip](https://www.7-zip.org/) - (official binary)
* [Jetbrains Toolbox](https://www.jetbrains.com/toolbox-app/) - (official "installer")
* [nvm](https://github.com/nvm-sh/nvm) - (official install script)
* [RustUp](https://rustup.rs/) - (official install script)

## Packages removed:
* akregator
* cheese
* gnome-boxes
* gnome-contacts
* gnome-maps
* gnome-tour
* gnome-weather
* elisa-player
* libreoffice (everything of it)
* kamaso
* kmahjongg
* kmines
* kmail
* kpat
* rhythmbox
* simple-scan
* totem
* yelp

## Alias:
* `dur` - `sudo dnf upgrade --refresh -y && flatpak upgrade -y && flatpak remove --unused`
* `mergepdf` - `mutool merge ./*.pdf`

## Configurations:
* Install `rpmfusion` repositories and additionally enable `rpmfusion-free-steam`
* Disable `google-chrome` repository
* Disable `phracek/PyCharm` COPR repository
* Add `flathub.org` repository in addition to the default Fedora flatpak repository