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

    vim = {
      enable = true;
      defaultEditor = true;

      plugins = with pkgs.vimPlugins; [
        ale
        airline
        fugitive
        fzf-vim
        nerdtree
        nerdtree-l-open-h-close
        surround
        vim-airline-themes
        vim-buffergator
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

        nmap <C-n> :NERDTreeToggle<CR>
        nmap <C-j> :NERDTreeFind<CR>
        let NERDTreeShowHidden=1
        let NERDTreeWinSize=45
        let NERDTreeChDirMode=2

        let g:airline_theme='deus'

        " Searching files and text
        nmap <C-p> :Files<CR>
        nmap <C-f> :Rg<CR>
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
      '';
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
