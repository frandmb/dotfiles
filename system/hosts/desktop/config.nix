{...}: {
  networking.hostName = "fran-desktop";
  networking.networkmanager.wifi = {
    powersave = false;
  };
  boot.kernelParams = ["pcie_aspm=off"];

  boot.extraModprobeConfig = ''
    options iwlwifi power_save=0
    options iwlwifi swcrypto=1
    options iwlwifi uapsd_disable=1
    options iwlmvm power_scheme=1
  '';

  boot.kernel.sysctl = {
    "net.core.default_qdisc" = "fq";
    "net.ipv4.tcp_congestion_control" = "bbr";
  };
  fileSystems."/mnt/nvme0n1p1" = {
    options = ["noatime"];
  };
}
