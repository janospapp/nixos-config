{
  always-center-single-column = true;

  preset-column-widths = [
    { proportion = 1. / 3.; }
    { proportion = 1. / 2.; }
    { proportion = 2. / 3.; }
  ];

  gaps = 20;

  focus-ring = {
    enable = true;
    width = 2;
  };

  border = {
    enable = false;
  };

  shadow = {
    enable = true;
    softness = 20;
    spread = 2;
    offset = {
      x = 0;
      y = 3;
    };
  };
}
