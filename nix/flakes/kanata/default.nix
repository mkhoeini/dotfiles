{
  stdenv,
  lib,
  fetchurl,
}:

let
  version = "1.6.1";
in
stdenv.mkDerivation {
  pname = "kanata";
  inherit version;

  src = fetchurl {
    url = "https://github.com/jtroo/kanata/releases/download/v${version}/kanata_macos_arm64";
    sha256 = "6gYIItqnDAKjTCsuqF81qmvaYpYLJ5ipetKo7lXvR/Y=";
  };

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/bin
    install -m755 $src $out/bin/kanata
  '';
}
