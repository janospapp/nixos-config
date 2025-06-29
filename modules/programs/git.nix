{ config, ... }:
{
  user.homePrograms.git = {
    enable = true;
    userName = config.user.name;
    userEmail = config.user.email;
  };
}
