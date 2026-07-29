# opencode bumped to the latest upstream release, reusing the nixpkgs build
# logic and only swapping the source + node_modules dependency hash.
prev:

prev.opencode.overrideAttrs (finalAttrs: old: {
  version = "1.18.7";
  src = prev.fetchFromGitHub {
    owner = "anomalyco";
    repo = "opencode";
    tag = "v${finalAttrs.version}";
    hash = "sha256-IgSKccqdmdfyWc+kVcV23FCF07KIOwDSidVLa4djIHE=";
  };
  node_modules = old.node_modules.overrideAttrs {
    inherit (finalAttrs) version src;
    outputHash = "sha256-Xjn8vYfF/dNOPg1es9Ob6p04Blbl9111WwBatAOChlg=";
  };
})
