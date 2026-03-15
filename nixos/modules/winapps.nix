{
  pkgs,
  inputs,
  system,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    inputs.winapps.packages.${system}.winapps
  ];
}
