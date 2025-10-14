{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    podman-compose
    dnsmasq
  ];
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["fran"];
  networking.firewall.trustedInterfaces = ["virbr0"];

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
    };
    libvirtd = {
      enable = true;
      qemu.runAsRoot = false;
    };
    spiceUSBRedirection.enable = true;
  };
}
