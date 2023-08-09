{ inputs, lib, config, pkgs, ... }: {
  home = {
    username = "janos";
    homeDirectory = "/home/janos";

    stateVersion = "23.05";
    packages = with pkgs; [ google-chrome kitty ];
  };

  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
      userName = "Janos Papp";
      userEmail = "papp.janos.90@gmail.com";
    };

    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      defaultKeymap = "viins";

      shellAliases = {
        k = "kubectl";
        dcu = "docker-compose up -d";
        dcd = "docker-compose down";
        bopen = "bundle open";
        bclean = "bundle pristine";
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
      '';

      plugins = [
        {
          name = "vi-mode";
          src = pkgs.zsh-vi-mode;
          file = "share/zsh-vi-mode/";
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
  };
}
