{ lib, ... }:
{
  options.users = {
    username = lib.mkOption {
      type = lib.types.string;
      default = "johndoe";
      description = "The username of the main user in the system.";
    };

    email = lib.mkOption {
      type = lib.types.string;
      default = "johndoe@example.com";
      description = "The email address of the main user in the system.";
    };
  };
}
