{
  lib,
  stdenv,
  fetchurl,
  undmg,
  makeWrapper,
  ffmpeg,
}:

stdenv.mkDerivation rec {
  pname = "spotidownloader";
  version = "7.0.8";

  src = fetchurl {
    url = "https://github.com/spotbye/SpotiDownloader/releases/download/v${version}/SpotiDownloader.dmg";
    sha256 = "1195cc364e932403fae5907d36cdeea8aeeb5ad38c22bbb100a1de528b0dff68";
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
    # Note: Updated from SpotiFLAC to SpotiDownloader
    APP_BIN="$out/Applications/SpotiDownloader.app/Contents/MacOS/SpotiDownloader"

    # 2. Wrap the executable to include FFmpeg in its PATH
    wrapProgram "$APP_BIN" \
      --prefix PATH : "${lib.makeBinPath [ ffmpeg ]}"
  '';

  meta = with lib; {
    description = "Spotify to FLAC downloader";
    homepage = "https://github.com/afkarxyz/SpotiDownloader";
    license = licenses.mit;
    maintainers = [ ];
    platforms = platforms.darwin;
  };
}
