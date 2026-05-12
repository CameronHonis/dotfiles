{ stdenv, fetchurl, autoPatchelfHook, pkgs }:
stdenv.mkDerivation {
  pname = "piactl";
  version = "3.7.2";
  src = fetchurl {
    url = "https://installers.privateinternetaccess.com/download/pia-linux-3.7.2-08420.run";
    sha256 = "sha256-CKiK8ERiqeB4ru9SsmvNtW8Kmwh6D7dgb5i363m7Pdk=";
  };
  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = with pkgs; [
    glib zlib pcre2
    libxkbcommon libGL wayland
    xorg.libXau xorg.libXdmcp xorg.libSM xorg.libICE xorg.libX11
    dbus fontconfig freetype libdrm
    libglvnd
  ] ++ [ stdenv.cc.cc.lib ];
  unpackPhase = "sh $src --target $out --noexec";
  installPhase = ''
    mkdir -p $out/bin $out/lib
    cp $out/piafiles/bin/piactl $out/bin/
    cp -r $out/piafiles/lib/* $out/lib/
    rm -rf $out/piafiles $out/installfiles $out/*.sh $out/*.txt $out/qml $out/plugins
  '';
  autoPatchelfIgnoreMissingDeps = [ "*" ];
}
