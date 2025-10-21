{
  location = "top";
  alignment = "center";
  lengthMode = "fill";
  height = 36;
  floating = true;
  hiding = "none";
  screen = 0;
  widgets = [
    {
      appMenu = {
        compactView = false;
      };
    }
    "org.kde.plasma.panelspacer"
    {
      systemTray = {
        items = {
          shown = [
            "org.kde.plasma.battery"
          ];
          configs = {
            battery.showPercentage = true;
            keyboardLayout.displayStyle = "label";
          };
        };
      };
    }
  ];
}
