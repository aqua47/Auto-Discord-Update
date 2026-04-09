install scripts:

sudo apt update
sudo apt install inotify-tools



clone git


mkdir -p ~/.config/systemd/user
mv service -> ~/.config/systemd/user/discord-watcher.service


systemctl --user start discord-watcher.service
systemctl --user enable discord-watcher.service
