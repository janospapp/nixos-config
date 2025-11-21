{
  user.homePrograms.yazi = {
    enable = true;
    enableZshIntegration = true;
    keymap = {
      mgr.prepend_keymap = [
        {
          on = [ "<C-p>" ];
          run = "plugin fzf";
          desc = "Search for files from the current directory";
        }
        {
          on = [ "<C-f>" ];
          run = "search --via=rg";
          desc = "Search for files by content from the current directory";
        }
      ];
    };
    settings.manager = {
      show_hidden = true;
      sort_dir_first = true;
    };
  };
}
