{lib, ...}: let
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
  };

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
    };
  };
}
