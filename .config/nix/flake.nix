{
  description = "User profile packages";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {

      packages.${system}.default = pkgs.buildEnv {
        name = "user-profile";
        paths = with pkgs; [
        anki-bin
        bat
        black
        bottom
        bzip3
		cmake
		docker
        dolt
        fd
		ffmpeg
        lazydocker
        lazygit
		libclang
        libffi
		libgcc
		libllvm
		gimp
		git
        gnupg
		gnumake
        go
        google-cloud-sdk
		htop
		imagemagick
        iperf
		kubectl
		maven
		#mongodb # broken
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
        protonvpn-gui
        pyenv
		python315
		redis
		ripgrep
        rustup
		samba
        screenfetch
		tmux
        tectonic
        testdisk
        tree-sitter
        unixODBC
        util-linux
        uv
        vcpkg
        vim
		wget
		wireshark
        xz
        zulu25 # openJDK
        ];
      };
    };
}
