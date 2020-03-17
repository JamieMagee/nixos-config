{ pkgs, lib, config, ... }: {

  home-manager.users.jamie.programs.git = {
    enable = true;
    userName = "Jamie Magee";
    userEmail = "jamie.magee@gmail.com";
    signing = {
      key = "4429B642B1718654";
      signByDefault = true;
    };
    aliases = {
      # List aliases
      aliases = "config --get-regexp alias";

      # Show verbose output about tags, branches or remotes
      tags = "tag -l";
      branches = "branch -a";
      remotes = "remote -v";

      # Switch to a branch, but don't create it
      co = "checkout";

      # Switch to a branch, and create it
      cob = "checkout -b";

      # Switch to a branch by task ID
      sco = "\"!f() { git branch -a | grep remotes | grep \"$1\" | xargs git checkout; }; f\"";

      # Edit the global `.gitconfig` file
      ec = "config --global -e";

      # Pull the latest changes from master, and rebase local changes on top of them
      up = "!git pull --rebase --prune $@ && git submodule update --init --recursive";

      cm = "!git add -A && git commit -m";
      bl = "branch -l";

      # Amend the currently staged files to the latest commit
      amend = "commit -a --amend";

      # Pretty print the git log
      lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";

      # Rebase the current branch onto the remote master
      rb = "!git fetch && git rebase origin/master";

      # Track upstream with the same name
      su = "!git branch --set-upstream-to=origin/\"$(git symbolic-ref --short HEAD)\"";

      # Manage git user identities
      work = "\"!f() { git config --local user.email \"jamagee@microsoft.com\"; }; f\"";
      personal = "\"!f() { git config --local user.email \"jamie.magee@gmail.com\"; }; f\"";
      whoami = "\"!f() { echo \"$(git config --get user.name)\" <\"$(git config --get user.email)\">; }; f\"";

      # Checkout PRs
      #pr  = "!f() { git fetch -fu ${2:-$(git remote |grep ^upstream || echo origin)} refs/pull/$1/head:pr/$1 && git checkout pr/$1; }; f";
      #pr-clean = "!git for-each-ref refs/heads/pr/* --format='%(refname)' | while read ref ; do branch=${ref#refs/heads/} ; git branch -D $branch ; done";
    };
    ignores = [
      "*~"
      # temporary files which can be created if a process still has a handle open of a deleted file
      ".fuse_hidden*"
      # KDE directory preferences
      ".directory"
      # Linux trash folder which might appear on any partition or disk
      ".Trash-*"
      # .nfs files are created when an open file is removed but is still being accessed
      ".nfs*"
    ];
    extraConfig = {
      core = {
        # Avoid using # symbol for comments -- instead use ;
        commentchar = "\";\"";
        safecrlf = false;
        autocrlf = "input";

        # Use custom `.gitignore`
        excludesfile = "~/.gitignore";

        # Speed up commands involving untracked files such as `git status`.
        # https://git-scm.com/docs/git-update-index#_untracked_cache
        untrackedCache = true;

        # Prettier diffs
        pager = "diff-so-fancy | less --tabs=4 -RFX";
      };
      branch = {
        # Rebase automatically on git pull
        autosetuprebase = "always";
      };
      apply = {
        # Detect whitespace errors when applying a patch
        whitespace = "fix";
      };
      push = {
        # https://git-scm.com/docs/git-config#git-config-pushdefault
        default = "current";
      };
      "color \"branch\"" = {
        current = "yellow reverse";
        local = "yellow";
        remote = "green";
      };
      "color \"diff\"" = {
        meta = "yellow";
        frag = "magenta bold";
        old = "red bold";
        new = "green bold";
        commit = "yellow bold";
        whitespace = "red reverse";
      };
      "color \"diff-highlight\"" = {
        oldNormal = "red bold";
        oldHighlight = "red bold 52";
        newNormal = "green bold";
        newHighlight = "green bold 22";
      };
      "color \"status\"" = {
        added = "yellow";
        changed = "green";
        untracked = "cyan";
      };
      help = {
        # Automatically correct and execute mistyped commands
        autocorrect = 1;
      };
      url = {
        "git@github.com:" = {
          insteadof = "gh:";
          pushInsteadOf = [
            "github.com:"
            "git://github.com/"
          ];
        };
        "git://github.com/" = {
          insteadOf = "github:";
        };
        "git@gist.github.com" = {
          insteadOf = "gst:";
          pushInsteadOf = [
            "gist:"
            "git://gist.github.com/"
          ];
        };
        "git://gist.github.com/" = {
          insteadOf = "gist:";
        };
      };
    };
    includes = [
      {
      condition = "gitdir:~/work/";
      path = "~/.gitconfig.work";
      contents = {
        user = {
          email = "jamagee@microsoft.com";
        };
        url = {
          "git@ssh.dev.azure.com:v3/powerbi/Customer360/" = {
            insteadof = "az:";
          };
        };
      };
    }
    ];
  };

}