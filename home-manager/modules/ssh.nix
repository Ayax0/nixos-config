{ ... }:

{
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
        SetEnv TERM=xterm
    '';
  };
}