{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkDefault;
in {
  services.logrotate.enable = false;
  services.logrotate.checkConfig = false;

  system.stateVersion = mkDefault "23.05";

  nixpkgs.config.allowUnfree = mkDefault true;

  nix.settings = {
    experimental-features = mkDefault [
      "nix-command"
      "flakes"
    ];
    keep-derivations = mkDefault true;
    keep-outputs = mkDefault true;
    auto-optimise-store = mkDefault true;
    sandbox = mkDefault true;
  };

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "FiraMono"
        "Iosevka"
      ];
    })
  ];

  console.keyMap = "colemak";

  time.timeZone = mkDefault "Europe/London";
  i18n.defaultLocale = mkDefault "en_GB.UTF-8";

  programs.direnv.enable = true;
  programs.git.enable = true;

  environment = {
    defaultPackages = lib.mkForce [];
    systemPackages = with pkgs; [
      statix
      alejandra
      deadnix
      nitch
      ncdu
      firefox
      obsidian
      vscode
    ];
    sessionVariables = {
      NIXPKGS_ALLOW_UNFREE = "1";
      NIXPKGS_ALLOW_INSECURE = "1";
      NIXOS_OZONE_WL = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
      __GL_GSYNC_ALLOWED = "0";
      __GL_SYNC_TO_VBLANK = "0";
      __GL_VRR_ALLOWED = "0";
      MOZ_DISABLE_RDD_SANDBOX = "1";
      MOZ_ENABLE_WAYLAND = "1";
      #WAYLAND_DISPLAY = "";
    };
  };
}
