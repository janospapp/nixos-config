let
  outputs = {
    desktop = {
      name = "HDMI-A-2";
      width = 2560.0;
      height = 1440.0;
      cx = 1280.0;
      loginCy = 1258.0;
      timeCy = 832.0;
      dateCy = 992.0;
    };

    laptop = {
      name = "eDP-1";
      width = 1920.0;
      height = 1080.0;
      cx = 960.0;
      loginCy = 898.0;
      timeCy = 524.0;
      dateCy = 684.0;
    };
  };

  loginSettings = {
    background_color = "surface_variant";
    background_opacity = 0.88;
    background_radius = 12.0;
    center_password_text = false;
    input_opacity = 1.0;
    input_radius = 6.0;
    layout = "regular";
    show_caps_lock = true;
    show_keyboard_layout = true;
    show_login_button = true;
    show_media = true;
    show_session_buttons = true;
    show_unlock_hint = true;
    show_weather = true;
  };

  timeSettings = {
    background = true;
    background_color = "on_primary";
    background_padding = 16;
    background_radius = 24;
    center_text = true;
    clock_style = "digital";
    color = "primary";
    format = "{:%H:%M}";
    shadow = true;
  };

  dateSettings = {
    background_color = "on_primary";
    color = "primary";
    format = "{:%d %B %Y}";
  };

  mkLoginBox = output: {
    box_height = 196.0;
    box_width = 810.0;
    cx = output.cx;
    cy = output.loginCy;
    output = output.name;
    placement_height = output.height;
    placement_width = output.width;
    rotation = 0.0;
    type = "login_box";
    settings = loginSettings;
  };

  mkTime = output: {
    box_height = 224.0;
    box_width = 810.0;
    cx = output.cx;
    cy = output.timeCy;
    output = output.name;
    placement_height = output.height;
    placement_width = output.width;
    rotation = 0.0;
    type = "clock";
    settings = timeSettings;
  };

  mkDate = output: {
    box_height = 64.0;
    box_width = 810.0;
    cx = output.cx;
    cy = output.dateCy;
    output = output.name;
    placement_height = output.height;
    placement_width = output.width;
    rotation = 0.0;
    type = "clock";
    settings = dateSettings;
  };
in
{
  enabled = true;
  schema_version = 2;

  widget_order = [
    "lockscreen-login-box@HDMI-A-2"
    "lockscreen-login-box@eDP-1"
    "desktop-time"
    "desktop-date"
    "laptop-time"
    "laptop-date"
  ];

  grid = {
    cell_size = 16;
    major_interval = 4;
    visible = true;
  };

  widget = {
    "lockscreen-login-box@HDMI-A-2" = mkLoginBox outputs.desktop;
    "lockscreen-login-box@eDP-1" = mkLoginBox outputs.laptop;

    desktop-time = mkTime outputs.desktop;
    desktop-date = mkDate outputs.desktop;

    laptop-time = mkTime outputs.laptop;
    laptop-date = mkDate outputs.laptop;
  };
}
