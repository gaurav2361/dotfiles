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
  version = "7.0.4";

  src = fetchurl {
    url = "https://github.com/afkarxyz/SpotiDownloader/releases/download/v${version}/SpotiDownloader.dmg";
    sha256 = "16c6133d260be23dd96486fe2f154e28425b28a71ff930babdc778b5171f5066";
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
