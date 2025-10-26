{ pkgs, ... }:

{
  home.packages = with pkgs; [ 
    (pkgs.writeShellScriptBin "keeweb" ''
      exec ${pkgs.keeweb}/bin/keeweb --no-sandbox "$@"
    '')
   ];
}