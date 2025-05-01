{
  user.homeConfig.kitty = {
    enable = true;
    themeFile = "Nord";

    keybindings = {
      "kitty_mod+t" = "new_tab_with_cwd tmux";
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
}
