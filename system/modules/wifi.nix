{pkgs, ...}: {
  networking = {
    wireless.enable = false;
    networkmanager = {
      wifi = {
        backend = "iwd";
      };
    };
  };
  hardware.wirelessRegulatoryDatabase = true;
  environment.systemPackages = with pkgs; [
    iw
  ];
  # boot.extraModprobeConfig = ''
  #   options cfg80211 ieee80211_regdom="US"
  # '';
}
