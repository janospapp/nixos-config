{ lib, ... }:
{
  options.users = {
    username = lib.mkOption {
      type = lib.types.str;
      example = "johndoe";
      description = "The username of the main user in the system.";
    };

    name = lib.mkOption {
      type = lib.types.str;
      example = "John Doe";
      description = "The name of the main user in the system.";
    };

    email = lib.mkOption {
      type = lib.types.str;
      example = "johndoe@example.com";
      description = "The email address of the main user in the system.";
    };
  };
}
