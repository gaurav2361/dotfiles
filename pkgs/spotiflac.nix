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
  version = "7.0.9";

  src = fetchurl {
    url = "https://github.com/afkarxyz/SpotiFLAC/releases/download/v${version}/SpotiFLAC.dmg";
    sha256 = "c268c2b84af05651d9d7f96ac98433193e6b5acf0337ab2fc17e8ce3f28a4ccc";
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
