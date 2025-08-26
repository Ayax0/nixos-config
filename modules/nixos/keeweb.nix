{ config, pkgs, ... }:
let
  keewebWrapped = pkgs.symlinkJoin {
    name = "keeweb-no-sandbox";
    paths = [ pkgs.keeweb ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/keeweb \
        --add-flags "--no-sandbox"
    '';
  };
in
{
  # Keeweb
  environment.shellAliases = {
    keeweb = "keeweb --no-sandbox";
  };

  # Client-Tools in PATH:
  environment.systemPackages = with pkgs; [ keewebWrapped ];
}
