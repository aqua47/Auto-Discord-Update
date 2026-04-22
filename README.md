# Discord Auto-Updater (ADU)

When there is a Discord update, Discord automatically downloads the new file, but it doesn't install automatically.

This project checks for the new file in the download folder of the user, installs it, and relaunches Discord.

## Compatibility

| OS      | Desktop Environment | Status  |
| -       | -                   | -       |
| Debian  | KDE                 | ✅      |
| Debian  | Gnome               | ❓      |
| Debian  | XFCE                | ❓      |
| Ubuntu  | Gnome               | ❓      |
| Kubuntu | KDE                 | ❓      |

## Install

```bash
sudo apt update
sudo apt install inotify-tools

git clone git@github.com:aqua47/Auto-Discord-Update.git
cd adu

mkdir -p ~/.local/bin/adu
mkdir -p ~/.config/adu

# Install files
mv watch_discord.sh update_discord.sh ~/.local/bin/adu/
mv config.conf ~/.config/adu/
chmod +x ~/.local/bin/adu/*.sh

# Systemd service setup
mkdir -p ~/.config/systemd/user
mv adu.service ~/.config/systemd/user/
systemctl --user start adu.service
systemctl --user enable adu.service

# editing the config file (~/.config/adu/config.conf) you can just copy this part to edit the config
nano ~/.config/adu/config.conf
systemctl --user restart adu.service
```


## Uninstall

```bash
systemctl --user stop adu.service
systemctl --user disable adu.service

rm ~/.config/systemd/user/adu.service
rm -rf ~/.local/bin/adu
rm -rf ~/.config/adu

systemctl --user daemon-reload
```