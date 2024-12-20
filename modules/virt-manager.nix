{...}: {
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["fran"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
}
