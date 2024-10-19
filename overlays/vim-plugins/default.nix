inputs: final: prev:
let
  arpeggio = prev.vimUtils.buildVimPlugin {
    name = "arpeggio";
    src = inputs.vim-arpeggio;
  };
  bundler = prev.vimUtils.buildVimPlugin {
    name = "vim-bundler";
    src = inputs.vim-bundler;
  };
  nerdtree-l-open-h-close = prev.vimUtils.buildVimPlugin {
    name = "nerdtree-l-open-h-close";
    src = inputs.vim-nerdtree-l-open-h-close;
  };
  vimux-ruby-test = prev.vimUtils.buildVimPlugin {
    name = "vimux-ruby-test";
    src = inputs.vimux-ruby-test;
  };
in
{
  vimPlugins = prev.vimPlugins // {
    inherit
      arpeggio
      bundler
      nerdtree-l-open-h-close
      vimux-ruby-test;
  };
}
