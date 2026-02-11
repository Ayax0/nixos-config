{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Simon Gander";
        email = "sg@vtt.ch";
      };
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}
