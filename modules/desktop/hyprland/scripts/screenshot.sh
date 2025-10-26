#!/usr/bin/env sh
# region screenshot + annotate
grim -g "$(slurp)" -t ppm - | satty --filename - \
  --output-filename ~/Pictures/Screenshots/screenshot_$(date '+%Y%m%d-%H:%M:%S').png
