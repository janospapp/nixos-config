inputs: final: prev:
let
  nerdtree-l-open-h-close = prev.vimUtils.buildVimPlugin {
    name = "nerdtree-l-open-h-close";
    src = inputs.nerdtree-l-open-h-close;
  };
in
{
  vimPlugins = prev.vimPlugins // {
    inherit nerdtree-l-open-h-close;
  };
}
