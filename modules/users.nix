{ lib, ... }:
{
  options.users = {
    username = lib.mkOption {
      type = lib.types.str;
      default = "johndoe";
      description = "The username of the main user in the system.";
    };

    email = lib.mkOption {
      type = lib.types.str;
      default = "johndoe@example.com";
      description = "The email address of the main user in the system.";
    };
  };
}
