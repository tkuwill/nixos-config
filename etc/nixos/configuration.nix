# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "willNixOS"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Asia/Taipei";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system. Windows manager and DE
  
  services.xserver.enable = true;
  services.xserver.displayManager.startx.enable = true;
 # services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true; 
  services.xserver.windowManager.dwm.enable = true;
  #services.xserver.windowManager.awesome.enable = true;
  # DWM, st, dmenu, custom build
  nixpkgs.overlays = [
     (final: prev: {
       dwm = prev.dwm.overrideAttrs (old: { src = /home/will/dwm ;});
      })   
      (import ./dmenu-overlay.nix)
      (self: super: {
            mpv = super.mpv.override {
              scripts = with self.mpvScripts; [ 
                mpris 
                mpv-playlistmanager
              ];
           };
       })
  ];

  # Service for gnome
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  # Service for thunar
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images
  # Service for polkit
  security.polkit.enable = true;
  systemd = {
  user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
  };
};
  # zsh's config
  programs.zsh.enable = true; 
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];  

  # sudoedit's editor
  environment.variables.EDITOR = "vim";  
 # Hardware acceleration
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
  # Configure keymap in X11
 services.xserver.layout = "us";
 # services.xserver.xkbOptions = {
 #   "eurosign:e";
 #   "caps:escape" # map caps to escape.
 # };

  # Enable CUPS to print documents.
 services.printing.enable = true;

  # Enable sound.
 sound.enable = true;
 hardware.pulseaudio.enable = true;
  # Virtualbox 
  virtualisation.virtualbox.host.enable = true;
  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;
  services.xserver.libinput.mouse.naturalScrolling = true;
  services.xserver.libinput.touchpad.naturalScrolling = true;
  # screen backlight
   programs.light.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.will = {
     isNormalUser = true;
     extraGroups = [ "wheel" "audio" "video" "networkmanager" "vboxusers" ]; # Enable ‘sudo’ for the user. Also, audio and video and virtualbox
     packages = with pkgs; [
     ];
   };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   nixpkgs.config.allowUnfree = true;
   environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     htop
     neofetch
     vifm
     xterm
     tmux
     xclip
     cmus
     easytag
     gpodder
     tree
     bat
     unar
     lazygit
     git
     zsh
     rofi
     newsboat
     arandr
     dunst
     pavucontrol
     flameshot
     curtail
     playerctl
     symbola
     copyq
     dmenu
    (st.override { 
	patches = [
           # You can specify local patches
           /home/will/st/patch/st-anysize-0.8.4.diff
   
         ];
	conf = builtins.readFile /home/will/st/config.h; })
     i3lock-color
     feh
     oneko
     # cli tools
     intel-gpu-tools
     lm_sensors
     acpi
     dialog
     libnotify
     w3m
     # video player
     yt-dlp
     ffmpeg
     mpv
     simplescreenrecorder
     # For web-development
     nodejs
     ## For office
     libreoffice-still-unwrapped
     font-manager
     zathura
     vimiv-qt
     ## Internet 
     firefox
     thunderbird
     chromium
     signal-desktop
     discord

     # thunar and its plugins
     xfce.thunar
     ## gnome programs
     gnomeExtensions.appindicator
     gnome.adwaita-icon-theme
     gnome.gnome-tweaks
     polkit_gnome
   ];

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gnome-console
    gnome.eog
  ]) ++ (with pkgs.gnome; [ 
    cheese
    gnome-music
    gnome-maps
    gnome-terminal
    gedit
    epiphany
    geary
    totem
    tali
    iagno
    hitori
    atomix
    nautilus
    eog

  ]);

 # thunar and its plugins
  programs.thunar.plugins = with pkgs.xfce; [
           thunar-volman
 ];

  # Input method ibus
#i18n.inputMethod = {
# enabled = "ibus";
# ibus.engines = with pkgs.ibus-engines; [ mozc libpinyin ];
#};
  # Input method fcitx5
   i18n.inputMethod = {
   enabled = "fcitx5";
   fcitx5.addons = with pkgs; [
       fcitx5-mozc
       fcitx5-gtk
       fcitx5-lua
       fcitx5-chinese-addons

    ];
  };


  # Font
  fonts.fonts = with pkgs; [
  noto-fonts
  noto-fonts-cjk
  noto-fonts-cjk-sans
  noto-fonts-cjk-serif
  noto-fonts-emoji
  noto-fonts-extra
  liberation_ttf
  fira-code
  fira-code-symbols
];



  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}

