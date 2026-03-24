{ lib }:
{
  # Helper to create a simple module with an enable option
  mkModule =
    {
      name,
      description ? "Enable ${name} module",
      config ? { },
    }:
    {
      options = lib.setAttrByPath (lib.splitString "." "modules.${name}") {
        enable = lib.mkEnableOption description;
      };
      config = lib.mkIf (lib.attrByPath (lib.splitString "." "modules.${name}.enable") false
        config
      ) config;
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
