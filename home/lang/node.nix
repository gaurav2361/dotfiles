{
  myLib,
  config,
  pkgs,
  lib,
  ...
}:
let
  npmGlobalDir = "${config.home.homeDirectory}/.npm";
in
myLib.mkHomeModule {
  globalConfig = config;
  name = "lang.node";
  description = "Node.js, Bun, and PNPM development environment";
  config = {
    home = {
      packages = with pkgs; [
        nodejs_24
        nodePackages.pnpm
        bun
        npm-check-updates
        npkill
        husky
        biome
      ];

      sessionVariables = {
        # Suppress experimental warnings (e.g., when using newer node features)
        NODE_OPTIONS = "--disable-warning=ExperimentalWarning";
      };

      sessionPath = [ "${npmGlobalDir}/bin" ];

      # Ensure the global npm directories exist for manual 'npm install -g'
      activation.initNode = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        $DRY_RUN_CMD mkdir -p ${npmGlobalDir}/bin ${npmGlobalDir}/lib
      '';

      file = {
        ".npmrc".text = ''
          prefix=${npmGlobalDir}
        '';

        ".bunfig.toml".text = ''
          [runtime]
          logLevel = "debug"
          telemetry = false

          [install]
          optional = true
          dev = true
          peer = true
          production = false
          exact = true
          auto = "fallback"
        '';
      };
    };
  };
}
