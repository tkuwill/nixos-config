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

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true; 

  # Service for gnome
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  # Service for thunar
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images
	

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

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.will = {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       firefox
       thunderbird
       chromium
       signal-desktop
       discord
     ];
   };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   nixpkgs.config.allowUnfree = true;
   environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     awesome
     htop
     neofetch
     vifm
     xterm
     tmux
     xclip
     cmus
     easytag
     tree
     bat
     unar
     lazygit
     git
     zsh
     rofi
     newsboat
     # cli tools
     lm_sensors
     acpi
     # video player
     yt-dlp
     mpv
     ##
     libreoffice-still-unwrapped
     # for wayland's programs
     foot
     wofi
     # thunar and its plugins
     xfce.thunar
     ## gnome programs
     gnomeExtensions.appindicator
     gnome.adwaita-icon-theme    
   ];

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gnome-console
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
  ]);

 # thunar and its plugins
  programs.thunar.plugins = with pkgs.xfce; [
           thunar-volman
 ];

  # Input method ibus
  i18n.inputMethod = {
  enabled = "ibus";
  ibus.engines = with pkgs.ibus-engines; [ mozc libpinyin ];
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

