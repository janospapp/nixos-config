{
  imports = [
    ./nfs-client.nix
  ];

  fileSystems = {
    "/mnt/data1" = {
      device = "192.168.50.102:/data1/";
      fsType = "nfs";
      options = [ "nfsvers=4" "x-systemd.automount" "noauto" ];
    };

    "/mnt/data2" = {
      device = "192.168.50.102:/data2/";
      fsType = "nfs";
      options = [ "nfsvers=4" "x-systemd.automount" "noauto" ];
    };

    "/mnt/service_data" = {
      device = "192.168.50.102:/service_data/";
      fsType = "nfs";
      options = [ "nfsvers=4" "x-systemd.automount" "noauto" ];
    };
  };
}
