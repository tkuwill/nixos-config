# nixos-config
my personal nixos-config on an old ASUS laptop.

## Files

- [configuration.nix][]
- [vifm][]
- [tmux][]
- [.zshrc][]
- [.vimrc][]

[configuration.nix]: https://github.com/tkuwill/nixos-config/blob/master/etc/nixos/configuration.nix
[.zshrc]: https://github.com/tkuwill/nixos-config/blob/master/.config/.zshrc
[.vimrc]: https://github.com/tkuwill/nixos-config/blob/master/.config/.vimrc
[vifm]: https://github.com/tkuwill/nixos-config/tree/master/.config/vifm
[tmux]: https://github.com/tkuwill/nixos-config/blob/master/.config/tmux/tmux.conf

## [How to update NixOS][]
[How to update NixOS]: https://discourse.nixos.org/t/how-to-upgrade-packages/6151/9


1. Check and set the latest channel
```bash
sudo nix-channel --list
```
If the channel is not the newest, run: 
```bash
sudo nix-channel --remove nixos
sudo nix-channel --add https://nixos.org/channels/nixos-XX.XX nixos
```
See [Chapter 4. Upgrading NixOS][] to check the latest channel.

[Chapter 4. Upgrading NixOS]: https://nixos.org/manual/nixos/stable/#sec-upgrading
2. Update the channel
```bash
sudo nix-channel --update
```

3. Update the packages
To update all packages declared in NixOS’ **configuration.nix**, use:
```bash
sudo nixos-rebuild switch
```
