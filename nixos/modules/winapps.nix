{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    inputs.winapps.packages.${pkgs.stdenv.hostPlatform.system}.winapps
  ];
}
