{ config, pkgs, lib, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  programs.fish.enable = true;

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

  #Other
  hardware.bluetooth.enable = true;
  # Keyboard layout

  services.xserver.xkb = {
    layout = "us,ru";
    options = "grp:alt_shift_toggle";
  };


  # Sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # User account with fish as default shell
  users.users.nixuser = {
    isNormalUser = true;
    description = "nixuser";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      git
      curl
      vim
    ];
  };

  # System packages
  environment.systemPackages = with pkgs; [
    # Build tools
    gnumake
    cmake

    # Qt Full
    qt6.full
    qt6.qtbase
    qt6.qtmultimedia
    qt6.qtwebengine

    # OpenGL и Vulkan
    mesa
    libGL
    libglvnd
    vulkan-loader
    vulkan-validation-layers
    shaderc
    vkd3d

    # Terminal & Media
    xterm  # Добавлен xterm
    alacritty
    vlc
    cava
    fastfetch
    mpv
    cataclysm-dda
    qbittorrent
    gparted
    nerd-fonts.hack

    # Python versions
    python310Full
    python311Full
    python312Full
    python314Full
    python313Full

    # Python packages
    python312Packages.mujoco
    python312Packages.torchaudio
    python312Packages.pip
    python312Packages.torch
    python312Packages.torchvision
    python312Packages.opencv4
    python312Packages.transformers
    python312Packages.numpy
    python312Packages.diffusers

     # Java
    openjdk8
    openjdk17
    openjdk21
    openjdk24
    openjfx17
    openjfx21
    openjfx24

    # Dev tools
    rustc
    maven
    gradle
    gcc14
    clang
    clang-tools
    clazy
    emacs
    neovim
    neovide
    fish
    nix-index
    go
    lua
    docker
    nixos-generators
    qtcreator
    gdb
    virtualbox
    sqlite
    nix-prefetch-git
    jq
    godot_4
    zed-editor
    nodejs
    ripgrep
    bottom
    btop
    tmux
    llvmPackages.libstdcxxClang
    meson
    ncurses
    SDL2
    sdl3
    SDL2_image
    SDL2_mixer
    SDL2_ttf
    freetype
    zlib
    bzip2
    gettext
    intltool
    libssh
    icu
    gimp3-with-plugins
    openssl
    jetbrains.idea-community
    ocl-icd
    opencl-headers
    opencl-clhpp
    netcat-gnu
    mujoco
    opencv
    devenv
    firejail
    vulkan-tools
    clinfo
    pocl
    nix-ld
    qemu
    poetry
    pyright
    kotlin
    pkg-config

    # 3D Software
    freecad
    blender

    # Mix
    stockfish
    en-croissant
    asciiquarium
    cheese
    astroterm
    briar-desktop

    # Creative apps
    krita
    kdePackages.kdenlive
    inkscape
    audacity
    obs-studio
    lmms

    # Editors & IDEs
    vscodium
    netbeans
    # Дополнительные зависимости
    v4l-utils
    ffmpeg

    # Bluetooth пакеты
    bluez

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
    tree
    ranger
    oh-my-fish
    patchelf
    zsh
    ltrace
    wget
    zip

    # KDE Apps
    kdePackages.dolphin
    kdePackages.konsole
    kdePackages.kate
    kdePackages.kcalc
    kdePackages.kclock
    kdePackages.kmix
    kdePackages.kscreen
    kdePackages.powerdevil
  ];

  # Set Alacritty as default terminal emulator via xdg
  environment.etc."xdg/xdg-kde/XDG_DATA_DIRS".text = ''
    ${pkgs.xterm}/share:${pkgs.alacritty}/share
  '';
  environment.variables.XDG_TERMINAL_EMULATOR = "alacritty";

  # Experimental features
  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
  };
programs.nix-ld.enable = true;
  # State version
  system.stateVersion = "25.05";
}
