# nixos-config
my personal nixos-config on an old ASUS laptop.


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
