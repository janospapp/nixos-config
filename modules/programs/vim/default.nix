{ config, pkgs, outputs, ... }:
{
  nixpkgs.overlays = [ outputs.overlays.vim-plugins ];

  home-manager.users.${config.user.username}.home = {
    file = {
      ".vim/scripts" = {
        source = ./scripts;
        recursive = true;
      };

      # Hack to create the swp directory
      ".vim/swp/.keep".source = builtins.toFile "keep" "";

      ".vim/UltiSnips" = {
        source = ./UltiSnips;
        recursive = true;
      };
    };
  };

  user.homeConfig.vim = {
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
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 2;
    };

    extraConfig = ''
      set listchars=tab:>-
      set list

      syntax on
      filetype plugin indent on
      set nowrap
      set encoding=utf8
      set tildeop
      colorscheme nord
      highlight Visual ctermfg=NONE
      highlight ExtraWhitespace ctermbg=red guibg=darkgreen
      match ExtraWhitespace /\s\+$\| \+\ze\t/

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

      " Breaking a line of arguments into multiple lines
      nmap <leader>b mz:s/\((\\|,\)\s*/\1\r/g<CR>:s/)/\r)<CR>=ap`z

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

      source $HOME/.vim/scripts/rails.vim
      nmap gs :call rails#ToggleSpecFile()<CR>
    '';
  };
}
