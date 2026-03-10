{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.shell.tools.eza;
in
{
  options.shell.tools.eza = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.shell.tools.enable;
      description = "eza replacement for ls";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.eza = {
      enable = true;
      enableZshIntegration = true;
      icons = "always";
      git = true;
      colors = "always";
      extraOptions = [
        "--group-directories-first"
        "--hyperlink"
        "--no-quotes"
        "--header"
        "--hyperlink"
      ];
    };

    # Set the EZA_COLORS environment variable to use the Catppuccin Mocha theme
    home.sessionVariables = {
      EZA_COLORS = lib.concatStringsSep ":" [
        # File types
        "*.md=38;5;229"
        "*.txt=38;5;229"
        "*.log=38;5;243"

        # Archives
        "*.tar=38;5;180"
        "*.tgz=38;5;180"
        "*.zip=38;5;180"
        "*.rar=38;5;180"
        "*.7z=38;5;180"

        # Images
        "*.jpg=38;5;222"
        "*.jpeg=38;5;222"
        "*.png=38;5;222"
        "*.gif=38;5;222"
        "*.svg=38;5;222"

        # Videos
        "*.mp4=38;5;210"
        "*.mkv=38;5;210"
        "*.avi=38;5;210"

        # Audio
        "*.mp3=38;5;156"
        "*.flac=38;5;156"
        "*.wav=38;5;156"

        # Documents
        "*.pdf=38;5;188"
        "*.doc=38;5;188"
        "*.docx=38;5;188"

        # Code
        "*.rs=38;5;180"
        "*.py=38;5;147"
        "*.js=38;5;222"
        "*.ts=38;5;147"
        "*.go=38;5;116"
        "*.nix=38;5;147"

        # Directories and files
        "di=38;5;147" # directories (Mauve)
        "ex=38;5;156" # executables (Green)
        "ln=38;5;117" # symlinks (Blue)
        "fi=38;5;188" # regular files (Text)

        # Git status
        "ga=38;5;156" # new (Green)
        "gm=38;5;222" # modified (Yellow)
        "gd=38;5;204" # deleted (Maroon)
        "gv=38;5;116" # renamed (Teal)
        "gt=38;5;213" # typechange (Pink)

        # Permissions
        "ur=38;5;210:1" # user read (Red, bold)
        "uw=38;5;222:1" # user write (Yellow, bold)
        "ux=38;5;156:1" # user execute (Green, bold)
        "ue=38;5;156:1" # user execute other (Green, bold)
        "gr=38;5;210" # group read (Red)
        "gw=38;5;222" # group write (Yellow)
        "gx=38;5;156" # group execute (Green)
        "tr=38;5;210" # other read (Red)
        "tw=38;5;222" # other write (Yellow)
        "tx=38;5;156" # other execute (Green)
        "su=38;5;147" # setuid (Mauve)
        "sf=38;5;147" # setgid (Mauve)
        "xa=38;5;151" # extended attribute (Overlay2)

        # Size colors
        "nb=38;5;189" # number byte
        "nk=38;5;151" # number kilo (Subtext0)
        "nm=38;5;117" # number mega (Blue)
        "ng=38;5;147" # number giga (Mauve)
        "nt=38;5;147" # number huge (Mauve)
        "ub=38;5;151" # unit byte
        "uk=38;5;116" # unit kilo (Teal)
        "um=38;5;147" # unit mega (Mauve)
        "ug=38;5;147" # unit giga (Mauve)
        "ut=38;5;116" # unit huge (Teal)

        # Users
        "uu=38;5;188" # user you (Text)
        "uR=38;5;210" # user root (Red)
        "un=38;5;204" # user other (Maroon)
        "gu=38;5;151" # group yours (Subtext0)
        "gn=38;5;151" # group other (Overlay2)
        "gR=38;5;210" # group root (Red)

        # Dates
        "da=38;5;222" # date (Yellow)

        # Punctuation
        "xx=38;5;108" # punctuation (Overlay0)
      ];
    };
  };
}
