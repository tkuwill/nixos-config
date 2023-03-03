# nixos-config
my personal nixos-config on an old ASUS laptop.

![](/screenshots/nix.png)

## Files

- [configuration.nix][]
- [vifm][]
- [tmux][]
- [.zshrc][]
- [.vimrc][]
- [.live-server.json][]

[configuration.nix]: https://github.com/tkuwill/nixos-config/blob/master/etc/nixos/configuration.nix
[.zshrc]: https://github.com/tkuwill/nixos-config/blob/master/.config/.zshrc
[.vimrc]: https://github.com/tkuwill/nixos-config/blob/master/.config/.vimrc
[vifm]: https://github.com/tkuwill/nixos-config/tree/master/.config/vifm
[tmux]: https://github.com/tkuwill/nixos-config/blob/master/.config/tmux/tmux.conf
[.live-server.json]: https://github.com/tkuwill/nixos-config/blob/master/.config/.live-server.json

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

## How to use `live-server` in NixOS ?

1. Check [Installing NPM Packages Globally in NixOS][] first.
    - After installing `NPM` and doing the config for npm in shell's rc, run `npm install -g live-server`.
2. Then check [live-server's config][].
    - Remember that the file `.live-server.json` should put in your **home directory**. Set the **root** for live-server, then use the command `live-server` in that **root directory**. It should work smoothly.


[Installing NPM Packages Globally in NixOS]: https://matthewrhone.dev/nixos-npm-globally
[live-server's config]: https://github.com/tapio/live-server/issues/105




