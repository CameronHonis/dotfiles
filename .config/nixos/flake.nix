{
	description = "my nixos config";
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
		nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
		nix-flatpak.url = "github:gmodena/nix-flatpak";
	};
	outputs = { self, nixpkgs, nixpkgs-unstable, nix-flatpak, ... }@inputs: {
		nixosConfigurations.rook = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
            specialArgs = { inherit (inputs) nixpkgs-unstable; };
			modules = [
				nix-flatpak.nixosModules.nix-flatpak
				./configuration.nix
			];
		};
	};
}
