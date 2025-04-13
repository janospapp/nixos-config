{ config, programs, ... }:
let
  username = config.users.username;
in {
  programs.git = {
    enable = true;
    userName = username;
    userEmail = config.users.email;
  };
}
