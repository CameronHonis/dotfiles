# rojo bumped to the latest upstream release, reusing the nixpkgs build logic
# and only swapping the source + cargo vendor dependency hashes.
prev:

prev.rojo.overrideAttrs (old: rec {
  version = "7.7.0";
  src = prev.fetchFromGitHub {
    owner = "rojo-rbx";
    repo = "rojo";
    tag = "v${version}";
    hash = "sha256-MPdftJX1WYG4n8bi0lwEymbEWl7XbvqI3ngs6i+fVAg=";
  };
  cargoDeps = prev.rustPlatform.fetchCargoVendor {
    inherit src;
    name = "rojo-${version}-vendor";
    hash = "sha256-1xTvW3Ra6erYpjxgfp2m8qVMz6u99WCDv2VE/Xh2mFc=";
  };
})
