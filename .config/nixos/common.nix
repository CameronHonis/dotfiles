{ config, pkgs, nixpkgs-unstable, ... }:

{
  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver.enable = true;

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  programs.dconf = {
    enable = true;
    profiles.user.databases = [{
      settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };
      };
    }];
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  swapDevices = [
    { device = "/var/lib/swapfile"; size = 32768; }
  ];

  users.users.camer = {
    isNormalUser = true;
    description = "main user";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
    ];
  };

  virtualisation.docker.enable = true;

  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    (final: prev: {
      neovim = nixpkgs-unstable.legacyPackages.${prev.stdenv.hostPlatform.system}.neovim;
      tree-sitter = nixpkgs-unstable.legacyPackages.${prev.stdenv.hostPlatform.system}.tree-sitter;
      beads = nixpkgs-unstable.legacyPackages.${prev.stdenv.hostPlatform.system}.beads;
      run-in-roblox = final.callPackage ./run-in-roblox.nix {};
    })
  ];

  environment.systemPackages = with pkgs; [
    anki-bin
    bat
    beads
    black
    blender
    bottom
    busybox
    bzip3
    caligula
    cmake
    desktop-file-utils
    discord
    docker
    dolt
    fd
    ffmpeg
    file
    gcc
    gimp
    git
    gnupg
    gnumake
    go
    google-chrome
    google-cloud-sdk
    htop
    imagemagick
    iperf
    isort
    kitty
    kubectl
    maven
    lazydocker
    lazygit
    libclang
    libffi
    libllvm
    neovim
    net-tools
    nfs-utils
    nginx
    nmap
    nodejs_24
    obs-studio
    opencode
    openssh
    os-prober
    pipx
    postgresql
    protobuf
    pyenv
    python315
    redis
    redocly
    ripgrep
    rojo
    run-in-roblox
    rustup
    samba
    screenfetch
    selene
    stylua
    tmux
    tectonic
    testdisk
    tree-sitter
    unixODBC
    util-linux
    uv
    vcpkg
    vim
    vinegar
    wally
    wget
    wireshark
    xclip
    xz
    zulu25
  ];

  services.openssh.enable = true;

  services.pia = {
    enable = true;
    authUserPassFile = "/etc/nixos/pia-credentials";
  };

  services.flatpak = {
    enable = true;
    packages = [
      { appId = "org.vinegarhq.Sober"; origin = "flathub"; }
    ];
  };

  system.stateVersion = "25.11";

  programs.nix-ld.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.variables.TERMINAL = "kitty";

  system.activationScripts.binbash = ''
    mkdir -m 0755 -p /bin
    ln -sfn ${pkgs.bash}/bin/bash /bin/bash
  '';

  environment.etc."xdg/applications/sober.desktop".text = ''
    [Desktop Entry]
    Name=Sober
    Exec=flatpak run org.vinegarhq.Sober
    Type=Application
    Categories=Game;
    Terminal=false
  '';
}
