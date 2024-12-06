{ inputs, outputs, system, pkgs, ... }:
let
  username = outputs.username;
in {
  home = let
    localPackages = with outputs.packages.${system}; [
      plasma-panel-templates
    ];
  in {
    inherit username;
    homeDirectory = "/home/${username}";

    stateVersion = "24.11";
    packages = with pkgs; [
      devenv
      kitty
      nordic
      obsidian
      papirus-icon-theme
      pinta
      slack
      spotify
      teams-for-linux
      tmux
    ] ++ localPackages;
  };

  programs = {
    home-manager.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    firefox = {
      enable = true;
      profiles.${username} = {
        extensions = with inputs.firefox-addons.packages.${system}; [
          bitwarden
          plasma-integration
          ublock-origin
        ];

        settings = {
          "widget.use-xdg-desktop-portal.file-picker" = 1;
          "widget.use-xdg-desktop-portal.mime-handler" = 1;
        };
      };
    };

    git = {
      enable = true;
      userName = "Janos Papp";
      userEmail = "papp.janos.90@gmail.com";
    };

    kitty = {
      enable = true;
      theme = "Nord";

      keybindings = {
        "kitty_mod+e" = "launch --location=vsplit --cwd=current";
        "kitty_mod+o" = "launch --location=hsplit --cwd=current";
        "kitty_mod+t" = "new_tab_with_cwd";
        "alt+up" = "neighboring_window up";
        "alt+left" = "neighboring_window left";
        "alt+right" = "neighboring_window right";
        "alt+down" = "neighboring_window down";
        "ctrl+page_down" = "next_tab";
        "ctrl+page_up" = "previous_tab";
      };

      settings = {
        enabled_layouts = "splits:split_axis:vertical, grid";
        font_size = "12.0";
        scrollback_lines = "10000";
        tab_bar_style = "powerline";
        tab_powerline_style = "slanted";
        tab_bar_min_tabs = "1";
      };

      shellIntegration = {
        enableZshIntegration = true;
      };
    };

    plasma = {
      enable = true;
      workspace.clickItemTo = "select";

      configFile = {
        kdeglobals = {
          Icons.Theme = "Papirus-Dark";
          KDE.LookAndFeelPackage = "Nordic-bluish";
        };
      };
    };

    tmux = {
      enable = true;
      keyMode = "vi";
      mouse = true;
      prefix = "C-a";
      terminal = "screen-256color";

      extraConfig = ''
        bind | split-window -h -c "#{pane_current_path}"
        bind - split-window -v -c "#{pane_current_path}"
        
        # Have a vim-like pane movement
        bind -n C-h run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys C-h) || tmux select-pane -L"
        bind -n C-j run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys C-j) || tmux select-pane -D"
        bind -n C-k run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys C-k) || tmux select-pane -U"
        bind -n C-l run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys C-l) || tmux select-pane -R"
        
        bind-key -T copy-mode-vi C-h select-pane -L
        bind-key -T copy-mode-vi C-j select-pane -D
        bind-key -T copy-mode-vi C-k select-pane -U
        bind-key -T copy-mode-vi C-l select-pane -R
        
        bind-key -n 'C-Space' resize-pane -Z
      '';
    };

    vim = {
      enable = true;
      defaultEditor = true;

      plugins = with pkgs.vimPlugins; [
        ale
        airline
        arpeggio
        bundler
        fugitive
        fzf-vim
        nerdtree
        nerdtree-l-open-h-close
        nord-vim
        ultisnips
        vim-airline-themes
        vim-endwise
        vim-surround
        vim-tmux-navigator
        vimux
        vimux-ruby-test
      ];

      settings = {
        directory = [ "~/.vim/swp/" ];
        expandtab = true;
        ignorecase = true;
        mouse = "a";
        number = true;
        relativenumber = true;
        shiftwidth = 2;
        tabstop = 2;
      };

      extraConfig = ''
        highlight ExtraWhitespace ctermbg=red guibg=darkgreen
        match ExtraWhitespace /\s\+$\| \+\ze\t/
        set listchars=tab:>-
        set list

        syntax on
        filetype plugin indent on
        set nowrap
        set encoding=utf8
        colorscheme nord
        highlight Visual ctermfg=NONE

        " NERDTree configuration
        nmap <C-n> :NERDTreeToggle<CR>
        nmap <leader>j :NERDTreeFind<CR>
        let NERDTreeShowHidden=1
        let NERDTreeWinSize=45
        let NERDTreeChDirMode=2
        let NERDTreeMapOpenSplit="s"
        let NERDTreeMapOpenVSplit="v"
        " Exit Vim if NERDTree is the only window remaining in the only tab.
        autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
        " If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
        autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
            \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

        let g:vimux_ruby_clear_console_on_run = 0
        let g:vimux_ruby_file_relative_paths = 1
        let g:tmux_navigator_disable_when_zoomed = 1
        let g:UltiSnipsExpandTrigger="<tab>"
        let g:UltiSnipsJumpForwardTrigger="<c-j>"
        let g:UltiSnipsJumpBackwardTrigger="<c-k>"
        let g:UltiSnipsEditSplit="vertical"
        let g:airline_theme='deus'

        " Searching files and text
        nmap <C-p> :Files<CR>
        nmap <C-f> :Rg<CR>
        nmap <C-b> :Buffers<CR>
        " Searching for the current word under the cursor
        nmap <leader>f :Rg \b<C-R><C-W>\b<CR>

        " Toggling the quickfix window with Ctrl+x
        function! ToggleQuickFix()
            if empty(filter(getwininfo(), 'v:val.quickfix'))
                copen
            else
                cclose
            endif
        endfunction

        nnoremap <C-x> :call ToggleQuickFix()<CR>

        " Configure ALE options
        let g:ale_set_highlights = 0
        let g:ale_completion_enabled = 1

        let g:ale_ruby_rubocop_executable = 'bundle'
        let g:ale_ruby_rubocop_options = '-c .rubocop.yml'

        let g:ale_linters = {
        \  'ruby': ['solargraph', 'standardrb', 'rubocop'],
        \}

        let g:ale_fixers={
        \  '*': ['remove_trailing_lines', 'trim_whitespace'],
        \  'ruby': ['standardrb', 'rubocop'],
        \}

        nmap gd :ALEGoToDefinition<CR>

        packloadall
        silent! helptags ALL

        " Arpeggio mappings
        Arpeggio noremap vi :VimuxInspectRunner<CR>
        Arpeggio noremap vp :VimuxPromptCommand<CR>
        Arpeggio noremap vl :VimuxRunLastCommand<CR>
        Arpeggio noremap rti :RunRubyFocusedTest<CR>
        Arpeggio noremap rtc :RunRubyFocusedContext<CR>
        Arpeggio noremap rtf :RunAllRubyTests<CR>
        Arpeggio noremap rta :VimuxRunCommand("rspec")<CR>
      '';
    };

    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
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

  services = {
    syncthing = {
      enable = true;
      tray.enable = true;
    };
  };
}
