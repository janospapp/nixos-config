{ config, ... }:
{
  user.homeConfig.git = {
    enable = true;
    userName = config.user.name;
    userEmail = config.user.email;
  };
}
