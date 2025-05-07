{ config, pkgs, lib, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Network & Localization
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "ru_RU.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  # X11 + KDE Plasma 6
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Keyboard layout
  services.xserver.xkb = {
    layout = "us,ru";
    options = "grp:alt_shift_toggle";
  };

  # Sound
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # User account
  users.users.vlad = {
    isNormalUser = true;
    description = "Vlad";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      git
      curl
      vim
      emacs
      neovim
      neovide
      fish
    ];
  };

  # System packages
  environment.systemPackages = with pkgs; [
    # Build tools
    gnumake
    cmake

    # Qt Full
    qt6.full

    # Terminal & Media
    alacritty
    vlc
    cava

    # Python versions
    python39
    python310
    python311
    python3

    # Java
    openjdk8
    openjdk17
    openjdk21

    # Dev tools
    rustc
    maven
    gradle
    gcc
    clang
    go
    lua
    docker

    # 3D Software
    freecad
    blender

    # Creative apps
    krita
    kdenlive

    # Editors & IDEs
    vim
    emacs
    neovim
    neovide
    vscodium

    # Browsers
    librewolf
    qutebrowser

    # Office
    libreoffice-fresh

    # Ai
    ollama
    llama-cpp
    # Shell & Tools
    fish
    uv
    pyenv
  ];

  # Experimental features
  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  # State version
  system.stateVersion = "24.05";
}
