{ inputs, ... }:
{
  imports = [
    ../modules/nixos/hardware/disko/server.nix
    ../modules/nixos/hardware/roxxy.nix
    ../modules/server.nix
  ];

  user = {
    username = "janos";
    name = "Janos Papp";
    email = "papp.janos.90@gmail.com";
    timeZone = "Europe/Budapest";
  };
  system = {
    hostname = "roxxy";
  };

  networking = {
    interfaces.enp2s0.ipv4.addresses = [
      {
        address = "192.168.50.102";
        prefixLength = 24;
      }
    ];
    defaultGateway = "192.168.50.1";
  };
}
