{ config, ... }:
let
  username = config.users.username;
in {
  home-manager.users.${username}.programs.git = {
    enable = true;
    userName = config.users.name;
    userEmail = config.users.email;
  };
}
