{
  user.homePrograms.tmux = {
    enable = true;
    disableConfirmationPrompt = true;
    keyMode = "vi";
    mouse = true;
    prefix = "C-a";
    terminal = "screen-256color";
    tmuxp.enable = true;

    extraConfig = ''
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"

      # Have a vim-like pane movement
      bind -n C-h if-shell '[ "#{@vim_active}" = "1" ]' 'send-keys C-h' 'select-pane -L'
      bind -n C-j if-shell '[ "#{@vim_active}" = "1" ]' 'send-keys C-j' 'select-pane -D'
      bind -n C-k if-shell '[ "#{@vim_active}" = "1" ]' 'send-keys C-k' 'select-pane -U'
      bind -n C-l if-shell '[ "#{@vim_active}" = "1" ]' 'send-keys C-l' 'select-pane -R'

      bind-key -T copy-mode-vi C-h select-pane -L
      bind-key -T copy-mode-vi C-j select-pane -D
      bind-key -T copy-mode-vi C-k select-pane -U
      bind-key -T copy-mode-vi C-l select-pane -R

      bind-key -n 'C-Space' resize-pane -Z

      set-option -g set-titles on
      set-option -g set-titles-string '#W'
    '';
  };
}
