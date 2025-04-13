{ pkgs, programs, ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "viins";

    shellAliases = {
      bclean = "bundle pristine";
      be = "bundle exec";
      bopen = "bundle open";
      dcd = "podman-compose down";
      dcu = "podman-compose up -d";
      k = "kubectl";
    };

    initExtra = ''
      zstyle ':completion:*' menu select

      bindkey -M viins '^l' end-of-line

      zmodload zsh/complist
      bindkey -M menuselect '^h' vi-backward-char
      bindkey -M menuselect '^j' vi-down-line-or-history
      bindkey -M menuselect '^k' vi-up-line-or-history
      bindkey -M menuselect '^l' vi-forward-char
      bindkey -M menuselect '\t' accept-line

      setopt autocd nomatch notify
      unsetopt beep

      eval "$(direnv hook zsh)"
    '';

    plugins = [
      {
        name = "vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ./p10k-config;
        file = "p10k.zsh";
      }
    ];
  };
}
