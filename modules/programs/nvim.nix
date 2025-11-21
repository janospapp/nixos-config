{ pkgs, ... }:
{
  user.homePrograms.nvf = {
    enable = true;

    settings = {
      vim.viAlias = false;
      vim.vimAlias = false;
      vim.globals.mapleader = " ";

      vim.treesitter.enable = true;
      vim.telescope.enable = true;
      vim.utility.oil-nvim.enable = true;
      vim.languages = {
        lua.enable = true;
        markdown.enable = true;
        nix.enable = true;
        ruby.enable = true;
        sql.enable = true;
        ts.enable = true;
      };

      vim.extraPlugins = {
        vim-tmux-navigator = {
          package = pkgs.vimPlugins.vim-tmux-navigator;
        };
      };
    };
  };
}
