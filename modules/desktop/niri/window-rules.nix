[
  {
    geometry-corner-radius = {
      top-left = 10.0;
      top-right = 10.0;
      bottom-left = 10.0;
      bottom-right = 10.0;
    };
    clip-to-geometry = true;
    opacity = 0.95;
  }
  {
    matches = [
      { app-id = "^kitty$"; }
    ];

    open-on-workspace = "tools";
  }
  {
    matches = [
      { app-id = "^firefox$"; }
    ];

    open-on-workspace = "browser";
  }
  {
    matches = [
      { app-id = "^spotify$"; }
    ];

    opacity = 0.9;
    open-focused = false;
    open-on-workspace = "media";
    default-column-width = {
      proportion = 0.7;
    };
    default-window-height = {
      proportion = 0.8;
    };
  }
]
