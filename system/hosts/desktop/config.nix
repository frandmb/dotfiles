{...}: {
  networking.hostName = "fran-desktop";
  networking.networkmanager.wifi = {
    powersave = false;
  };
  fileSystems."/mnt/nvme0n1p1" = {
    options = ["noatime"];
  };
}
