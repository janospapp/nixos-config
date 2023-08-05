{ inputs, lib, config, pkgs, ... }: {
  home = {
    username = "janos";
    homeDirectory = "/home/janos";

    stateVersion = "23.05";
    packages = with pkgs; [ google-chrome kitty ];
  };

  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
      userName = "Janos Papp";
      userEmail = "papp.janos.90@gmail.com";
    };
  };
}
