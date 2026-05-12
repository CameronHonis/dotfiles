{
	description = "my nixos config";
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
		nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
	};
	outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs: {
		nixosConfigurations.rook = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
            specialArgs = { inherit (inputs) nixpkgs-unstable; };
			modules = [
				./configuration.nix
			];
		};
	};
}
