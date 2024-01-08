{...}: {
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

  services.xserver.desktopManager.gnome.enable = true;

  modules = {
    bash.enable = true;
    foot.enable = true;
    kernel.enable = true;
    networkmanager.enable = true;
    nvidia.enable = true;
    pipewire.enable = true;
    prismlauncher.enable = true;
    systemd-boot.enable = true;
    zram.enable = true;
  };
}
