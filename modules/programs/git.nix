{ config, ... }:
{
  user.homePrograms.git = {
    enable = true;
    settings.user = {
      name = config.user.name;
      email = config.user.email;
    };
  };
}
