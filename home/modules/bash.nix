{ pkgs, ... }: {
  programs.bash = {
    enable = true;

    initExtra = ''
      if [ -f "$HOME/.profile" ]; then
          . "$HOME/.profile"
        fi

        if [ "$TERM" = "xterm-kitty" ]; then
          alias ssh="kitty +kitten ssh"
        fi

        PS1='\n\[\033[1;32m\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\$\[\033[0m\] '
    '';

    shellAliases = {
      rebuild = "cd ~/nix-config && sudo nixos-rebuild switch --flake .#$NIX_HOST; cd -";
      ".." = "cd ..";
      "..." = "cd ../..";
      vi = "nvim";
      vim = "nvim";
      mkdir = "mkdir -pv";
    };
  };

  programs.tmux = {
    enable = true;
    shell = "${pkgs.bash}/bin/bash";
    shortcut = "a";
    baseIndex = 1;
    newSession = true;
    escapeTime = 0;
    secureSocket = false;
    clock24 = true;
    historyLimit = 50000;

    extraConfig = ''
      # https://old.reddit.com/r/tmux/comments/mesrci/tmux_2_doesnt_seem_to_use_256_colors/
      #set -g default-terminal "xterm-256color"
      #set -ga terminal-overrides ",*256col*:Tc"
      #set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      #set-environment -g COLORTERM "truecolor"

      # easy-to-remember split pane commands
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
    '';
  };
}
