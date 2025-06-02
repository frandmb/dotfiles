{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    podman-compose
  ];
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["fran"];

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
    };
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };
}
