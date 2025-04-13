pkgs:
{
  git = import ./core/git.nix;
  kitty = import ./core/kitty.nix;
  tmux = import ./core/tmux.nix;
  vim = import ./core/vim.nix pkgs;
  zsh = import ./core/zsh pkgs;
}
