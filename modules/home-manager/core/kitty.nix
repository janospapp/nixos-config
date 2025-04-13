{ config, ... }:
let
  username = config.users.username;
in {
  home-manager.users.${username}.programs.kitty = {
    enable = true;
    themeFile = "Nord";

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
}
