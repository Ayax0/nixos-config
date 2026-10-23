{ ... }:

{
  programs.git = {
    enable = true;
    ignores = [
      "**/.claude/settings.local.json"
      ".direnv/"
      ".envrc"
    ];
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
