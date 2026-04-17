{
  lib,
  stdenv,
  fetchurl,
  undmg,
  makeWrapper,
  ffmpeg,
}:

stdenv.mkDerivation rec {
  pname = "spotiflac";
  version = "7.1.3";

  src = fetchurl {
    url = "https://github.com/spotbye/SpotiFLAC/releases/download/v${version}/SpotiFLAC.dmg";
    sha256 = "d1918dc11b634b3bc9e81ecc82e0fa8f21fa6e6f30b34a01bfc00c72b9672424";
  };

  # makeWrapper is needed to inject ffmpeg into the app's environment
  nativeBuildInputs = [
    undmg
    makeWrapper
  ];

  # Add ffmpeg here so we can reference it
  buildInputs = [ ffmpeg ];

  sourceRoot = ".";

  installPhase = ''
    mkdir -p $out/Applications
    cp -r *.app $out/Applications

    # 1. Identify the executable path inside the .app bundle
    APP_BIN="$out/Applications/SpotiFLAC.app/Contents/MacOS/SpotiFLAC"

    # 2. Wrap the executable to include FFmpeg in its PATH
    # This ensures that when the app tries to run 'ffmpeg', it finds the Nix version
    wrapProgram "$APP_BIN" \
      --prefix PATH : "${lib.makeBinPath [ ffmpeg ]}"
  '';

  meta = with lib; {
    description = "Spotify to FLAC downloader";
    homepage = "https://github.com/afkarxyz/SpotiFLAC";
    license = licenses.mit;
    maintainers = [ ];
    platforms = platforms.darwin;
  };
}
