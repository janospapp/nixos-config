let
  externalMonitor = "Microstep MSI MP271Q PA3T090C00145";
  laptopMonitor = "eDP-1";
in
{
  "11-tools" = {
    name = "tools";
    open-on-output = externalMonitor;
  };
  "12-browser" = {
    name = "browser";
    open-on-output = externalMonitor;
  };
  "21-media" = {
    name = "media";
    open-on-output = laptopMonitor;
  };
}
