{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    podman-compose
    dnsmasq
    docker-compose
  ];

  programs.virt-manager.enable = true;

  networking.firewall.trustedInterfaces = ["virbr0"];
  users.users.fran = {
    extraGroups = ["libvirtd"];
  };
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
    };
    libvirtd = {
      qemu = {
        vhostUserPackages = with pkgs; [virtiofsd];
      };

      enable = true;
    };
    spiceUSBRedirection.enable = true;
  };
}
