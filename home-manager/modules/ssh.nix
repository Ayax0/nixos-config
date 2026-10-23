{ ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings."*".SetEnv.TERM = "xterm";
  };
}
