{ lib }:
{
  # Helper to create a simple module with an enable option
  mkModule =
    {
      name,
      description ? "Enable ${name} module",
      options ? { },
      config,
      globalConfig,
      declareEnable ? true,
    }:
    {
      options = lib.setAttrByPath (lib.splitString "." "modules.${name}") (
        lib.optionalAttrs declareEnable {
          enable = lib.mkEnableOption description;
        }
        // options
      );
      config = lib.mkIf (lib.attrByPath (lib.splitString "." "modules.${name}.enable") false globalConfig) config;
    };

  # Helper to create a simple module with an enable option for Home Manager (no predefined prefix)
  mkHomeModule =
    {
      name,
      description ? "Enable ${name} module",
      options ? { },
      config,
      globalConfig,
      enableDefault ? false,
      declareEnable ? true,
    }:
    {
      options = lib.setAttrByPath (lib.splitString "." name) (
        lib.optionalAttrs declareEnable {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = enableDefault;
            description = description;
          };
        }
        // options
      );
      config = lib.mkIf (lib.attrByPath (lib.splitString "." "${name}.enable") enableDefault globalConfig) config;
    };

  # Helper for boolean options
  mkBoolOpt =
    default: description:
    lib.mkOption {
      inherit default description;
      type = lib.types.bool;
    };

  # Helper for string options
  mkStrOpt =
    default: description:
    lib.mkOption {
      inherit default description;
      type = lib.types.str;
    };

  # Helper for package lists
  mkPkgOpt =
    default: description:
    lib.mkOption {
      inherit default description;
      type = lib.types.listOf lib.types.package;
    };
}
