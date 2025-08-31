{
  fileSystems = {
    "/mnt/data1" = {
      device = "/dev/disk/by-uuid/ea5f923b-082c-4249-b3f7-1ab46eafc0e6";
      fsType = "ext4";
    };

    "/mnt/data2" = {
      device = "/dev/disk/by-uuid/9f3dfc3a-9b24-48c9-aaf8-fdd599dedd39";
      fsType = "ext4";
    };

    # Directories for NFS export
    "/export/data1" = {
      device = "/mnt/data1";
      options = [ "bind" ];
    };
    "/export/data2" = {
      device = "/mnt/data2";
      options = [ "bind" ];
    };
    "/export/service_data" = {
      device = "/data/.state";
      options = [ "bind" ];
    };
  };
}
