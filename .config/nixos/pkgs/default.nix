# Overlay assembling all custom / bumped packages.
# Each package lives in its own file under this directory.
final: prev:

{
  run-in-roblox = final.callPackage ./run-in-roblox.nix { };
  opencode = import ./opencode.nix prev;
  rojo = import ./rojo.nix prev;
}
