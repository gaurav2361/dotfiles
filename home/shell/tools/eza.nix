{
  myLib,
  config,
  pkgs,
  lib,
  ...
}:
myLib.mkHomeModule {
  globalConfig = config;
  name = "shell.tools.eza";
  description = "eza replacement for ls";
  enableDefault = config.shell.tools.enable or false;
  config = {
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

    home.sessionVariables = {
      EZA_COLORS = lib.concatStringsSep ":" [
        "*.md=38;5;229"
        "*.txt=38;5;229"
        "*.log=38;5;243"
        "*.tar=38;5;180"
        "*.tgz=38;5;180"
        "*.zip=38;5;180"
        "*.rar=38;5;180"
        "*.7z=38;5;180"
        "*.jpg=38;5;222"
        "*.jpeg=38;5;222"
        "*.png=38;5;222"
        "*.gif=38;5;222"
        "*.svg=38;5;222"
        "*.mp4=38;5;210"
        "*.mkv=38;5;210"
        "*.avi=38;5;210"
        "*.mp3=38;5;156"
        "*.flac=38;5;156"
        "*.wav=38;5;156"
        "*.pdf=38;5;188"
        "*.doc=38;5;188"
        "*.docx=38;5;188"
        "*.rs=38;5;180"
        "*.py=38;5;147"
        "*.js=38;5;222"
        "*.ts=38;5;147"
        "*.go=38;5;116"
        "*.nix=38;5;147"
        "di=38;5;147"
        "ex=38;5;156"
        "ln=38;5;117"
        "fi=38;5;188"
        "ga=38;5;156"
        "gm=38;5;222"
        "gd=38;5;204"
        "gv=38;5;116"
        "gt=38;5;213"
        "ur=38;5;210:1"
        "uw=38;5;222:1"
        "ux=38;5;156:1"
        "ue=38;5;156:1"
        "gr=38;5;210"
        "gw=38;5;222"
        "gx=38;5;156"
        "tr=38;5;210"
        "tw=38;5;222"
        "tx=38;5;156"
        "su=38;5;147"
        "sf=38;5;147"
        "xa=38;5;151"
        "nb=38;5;189"
        "nk=38;5;151"
        "nm=38;5;117"
        "ng=38;5;147"
        "nt=38;5;147"
        "ub=38;5;151"
        "uk=38;5;116"
        "um=38;5;147"
        "ug=38;5;147"
        "ut=38;5;116"
        "uu=38;5;188"
        "uR=38;5;210"
        "un=38;5;204"
        "gu=38;5;151"
        "gn=38;5;151"
        "gR=38;5;210"
        "da=38;5;222"
        "xx=38;5;108"
      ];
    };
  };
}
