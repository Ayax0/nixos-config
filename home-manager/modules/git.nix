{ ... }:

{
  programs.git = {
    enable = true;
    userName = "Simon Gander";
    userEmail = "sg@vtt.ch";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}
