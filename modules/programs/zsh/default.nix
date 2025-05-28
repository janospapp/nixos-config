{ config, lib, pkgs, ... }:
let
  cfg = config.zsh;
in {
  options.zsh = {
    extraRcParts = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = ''
        Sections of the final .zshrc file. Add items to the list, and
        it will be concatenated at the end. Useful for custom key bindings
        or function definitions from different modules.
      '';
    };
  };

  config = {
    user.homeConfig.zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      defaultKeymap = "viins";

      shellAliases = {
        be = "bundle exec";
        k = "kubectl";
        kg = "kubectl get";
        kns = "kubens";
        kcx = "kubectx";
        pcd = "podman-compose down";
        pcu = "podman-compose up -d";
        pcs = "podman-compose -f docker-compose.yml start";
        rails = "be rails";
        rake = "be rake";
        rspec = "be rspec";
      };

      initContent = ''
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

        ${cfg.extraRcParts}

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
  };
}
