{
  lib,
  config,
  ...
}: {
  options.modules.nvidia.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.nvidia.enable {
    hardware.nvidia = {
      modesetting.enable = true;
      open = true;
    };
  };
}
