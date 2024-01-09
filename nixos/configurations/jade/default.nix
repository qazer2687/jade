{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkDefault;
in {
  imports = [
    ../../../hardware/jade
    ../../modules
  ];

  networking.hostName = "jade";

  users.users.alex = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "video"];
  };

  environment.etc = {
    issue = {
      text = ''\e[32mWelcome to Jade!\e[0m'';
    };
  };

  modules = {
    bash.enable = true;
    kernel.enable = true;
    networkmanager.enable = true;
    nvidia.enable = true;
    pipewire.enable = true;
    prismlauncher.enable = true;
    systemd-boot.enable = true;
    zram.enable = true;
  };

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

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;

  console.keyMap = "colemak";
  

  time.timeZone = mkDefault "Europe/London";
  i18n.defaultLocale = mkDefault "en_GB.UTF-8";

  programs.direnv.enable = true;
  programs.git.enable = true;

  environment = {
    defaultPackages = lib.mkForce [];
    systemPackages = with pkgs; [
      firefox
      obsidian
      vscodium-fhs
    ];
    sessionVariables = {
      NIXPKGS_ALLOW_UNFREE = "1";
      NIXPKGS_ALLOW_INSECURE = "1";
    };
  };
}
