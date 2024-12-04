{ ... }:
{
  networking.hostName = "fran-laptop";
  environment.variables = {
    # Override for 780m iGpu
    HSA_OVERRIDE_GFX_VERSION = "11.0.0";
  };
}
