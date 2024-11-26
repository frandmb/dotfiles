{ ... }:
{
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "046d:b36d:ea269e7e" ];
        settings = {
          main = {
            leftalt = "leftmeta";
            leftmeta = "leftalt";
            rightmeta = "rightalt";
            rightalt = "rightctrl";
          };
        };
      };
    };
  };
}
