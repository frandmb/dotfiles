{config, ...}: {
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 card_label="Webcam" exclusive_caps=1
  '';
}
