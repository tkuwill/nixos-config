# nixos-config
my personal nixos-config on an old ASUS laptop.

<div align="center">
	<img width="100" src="/screenshots/nixos.png">
</div>

![](/screenshots/nix.png)
<div align="center">
	<h6>dwm</h6>
</div>

![](/screenshots/i3nix.jpg)
> Use i3blocks

![](/screenshots/i3nix2.jpg)
> Use polybar

<div align="center">
	<h6>i3</h6>
</div>

![](/screenshots/bspnix.jpg)

<div align="center">
	<h6>bspwm</h6>
</div>

![](/screenshots/hypr.png)

<div align="center">
	<h6>hyprland</h6>
</div>


- Here are some skills of using `NixOS`, `live-server` and  dotfiles used on my **NixOS**.
- Wallpaper are from [李擎洲：九尾·妖狐][] and [彭雄渾][] and [Free 4k Wallpaper Photos][].
- bspwm's config is from [ghomasHudson/bspwm-dwm][]. And add some customized change like keybindings to open dmenu's scripts.
- [TVbsp.sh][] is a script for turning off laptop's screen and setting up workspaces on the external screen.
- [lay.sh][] is a script for showing windows layout on polybar in bspwm.
- If you want to learn bspwm, check this: [Bspwm Basics][].
- I use [tofi][] as a replacement of dmenu in Hyprland.
- In NixOS, you should use an [overlay][] to fix the waybar's workspace module if you want to use Hyprland. (In my config, it can show workspaces but it can not be clicked.)



[overlay]: https://github.com/tkuwill/nixos-config/blob/master/etc/nixos/configuration.nix#LL85C16-L85C16
[tofi]: https://github.com/philj56/tofi
[lay.sh]: https://github.com/tkuwill/nixos-config/blob/master/.config/polybar/lay.sh
[Bspwm Basics]: https://dharmx.is-a.dev/bspwm-basics/
[TVbsp.sh]: https://github.com/tkuwill/nixos-config/blob/master/shellscripts/TVbsp.sh
[ghomasHudson/bspwm-dwm]: https://github.com/ghomasHudson/bspwm-dwm
[Free 4k Wallpaper Photos]: https://www.pexels.com/photo/brown-and-green-mountain-view-photo-842711/
[李擎洲：九尾·妖狐]: https://www.bilibili.com/video/BV1iN4y1F7pm/
[彭雄渾]: https://artouch.com/art-views/content-3244.html

## Files

<details>

- [configuration.nix][]
- [vifm][]
- [tmux][]
- [.zshrc][]
- [.vimrc][]
- [.live-server.json][]
- [.npmrc][]

[configuration.nix]: https://github.com/tkuwill/nixos-config/blob/master/etc/nixos/configuration.nix
[.zshrc]: https://github.com/tkuwill/nixos-config/blob/master/.config/.zshrc
[.vimrc]: https://github.com/tkuwill/nixos-config/blob/master/.config/.vimrc
[vifm]: https://github.com/tkuwill/nixos-config/tree/master/.config/vifm
[tmux]: https://github.com/tkuwill/nixos-config/blob/master/.config/tmux/tmux.conf
[.live-server.json]: https://github.com/tkuwill/nixos-config/blob/master/.config/.live-server.json
[.npmrc]: https://github.com/tkuwill/nixos-config/blob/master/.config/.npmrc

</details>

## [How to update NixOS][]

<details>

[How to update NixOS]: https://discourse.nixos.org/t/how-to-upgrade-packages/6151/9

Steps for updating NixOS:  
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

</details>

## How to [Show all packages installed in NixOS][] ?

<details>

1. Show `environment.systemPackages` in `/etc/nixos/configuration.nix`
```bash
nix-store --query --requisites /run/current-system | cut -d- -f2- | sort | uniq | bat
```
or
```bash
nix-store --query --requisites /run/current-system | cut -c 45-200 | sort | uniq | bat
```

[Show all packages installed in NixOS]: https://functor.tokyo/blog/2018-02-20-show-packages-installed-on-nixos

</details>


## How to show all boot entries in NixOS ?

<details>

```
sudo nix-env -p /nix/var/nix/profiles/system --list-generations
```



</details>

## How to [Delete Old Generations On NixOS][] ?

<details>

For system-wide, run:  
1. You can change `30d` to the days you want.
```nix
sudo nix-collect-garbage --delete-older-than 30d
```
or you can run ```sudo nix-collect-garbage -d ``` to delete all old generations. (Of course, **this would make rollback impossible**.)

2. Then run the rebuild command to clean **the boot entries of old generations of nixos**.
```nix
sudo nixos-rebuild switch
```
For per-user, run those commands without `sudo`. Check the [Nix Reference Manual][] for more detailed information.

[Nix Reference Manual]: https://nixos.org/manual/nix/stable/package-management/garbage-collection.html
[Delete Old Generations On NixOS]: https://ersocon.net/articles/nixos-remove-old-generations~0332c9e7-5c49-4cd9-b706-559356e31390

</details>

## How to use `live-server` in NixOS ?

<details>

1. Check [Installing NPM Packages Globally in NixOS][] first.
    - After installing `NPM` and doing the config for npm in shell's rc, run `npm install -g live-server`.
2. Then check [live-server's config][].
    - Remember that the file `.live-server.json` should put in your **home directory**. Set the **root** for live-server, then use the command `live-server` in that **root directory**. It should work smoothly.


[Installing NPM Packages Globally in NixOS]: https://matthewrhone.dev/nixos-npm-globally
[live-server's config]: https://github.com/tapio/live-server/issues/105

</details>


## Memo 

<details>

Next time when installing NixOS, make `/efi` (`/boot`) big enough (**like 1~2GB**), or you will have to delete boot menu constantly.(Of course, maybe it is because I care about the space of `/boot` too much).






</details>

