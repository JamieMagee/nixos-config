{ pkgs, ... }:
let
  inherit (builtins) readFile;
in
{
  programs.git = {
    enable = true;

    userName = "Jamie Magee";
    userEmail = "jamie.magee@gmail.com";

    signing = {
      key = "4429B642B1718654";
      signByDefault = false;
    };

    extraConfig = {
      core = {
        commentchar = ";";
        safecrlf = false;
        autocrlf = "input";
        excludesfile = "${pkgs.writeText ".gitignore"
          ''
          *~

          # temporary files which can be created if a process still has a handle open of a deleted file
          .fuse_hidden*

          # KDE directory preferences
          .directory

          # Linux trash folder which might appear on any partition or disk
          .Trash-*

          # .nfs files are created when an open file is removed but is still being accessed
          .nfs*
          ''}";
          # Speed up commands involving untracked files such as `git status`.
          # https://git-scm.com/docs/git-update-index#_untracked_cache
          untrackedCache = true;
          pager = "${pkgs.gitAndTools.diff-so-fancy} | ${pkgs.less} --tabs=4 RFX";
      };
      pull.rebase = false;
    };

    aliases = {
      a = "add -p";
      co = "checkout";
      cob = "checkout -b";
      f = "fetch -p";
      c = "commit";
      p = "push";
      ba = "branch -a";
      bd = "branch -d";
      bD = "branch -D";
      d = "diff";
      dc = "diff --cached";
      ds = "diff --staged";
      r = "restore";
      rs = "restore --staged";
      st = "status -sb";

      whoami = "!sh -c 'echo \"$(git config --get user.name) <$(git config --get user.email)>\"'";

      # reset
      soft = "reset --soft";
      hard = "reset --hard";
      s1ft = "soft HEAD~1";
      h1rd = "hard HEAD~1";

      # logging
      lg =
        "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      plog =
        "log --graph --pretty='format:%C(red)%d%C(reset) %C(yellow)%h%C(reset) %ar %C(green)%aN%C(reset) %s'";
      tlog =
        "log --stat --since='1 Day Ago' --graph --pretty=oneline --abbrev-commit --date=relative";
      rank = "shortlog -sn --no-merges";

      # delete merged branches
      bdm = "!git branch --merged | grep -v '*' | xargs -n 1 git branch -d";
    };
  };
}
