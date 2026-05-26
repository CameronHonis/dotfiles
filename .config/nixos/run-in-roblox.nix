{ lib, rustPlatform, fetchFromGitHub }:

rustPlatform.buildRustPackage rec {
  pname = "run-in-roblox";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "CameronHonis";
    repo = "run-in-roblox";
    rev = "main";
    sha256 = "sha256-p+ryx92ogj0cineCRsL5Hq6NXeMYSAET0lGx751mGkg=";
  };

  cargoHash = "sha256-76SH+xx3A64Umu0v7azY0MhUtGbHwQOJiSwxfdLWzxs=";

  meta = with lib; {
    description = "Run a place, model, or individual script inside Roblox Studio";
    homepage = "https://github.com/CameronHonis/run-in-roblox";
    license = licenses.mit;
    maintainers = [];
  };
}