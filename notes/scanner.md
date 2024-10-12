# Setting up Epson Perfection V19 scanner

I had to enable SANE in my config and install the `epkowa` backend.
As it's a non-free package, nix didn't load it from the binary cache
and wanted to build from source.

The package needed a few files from Epson support, which it couldn't
download programatically (got 403 error), and falled back to Web Archive
to download the files. However this also failed as Web Archive just got
a serious DDoS attach recently and their site is also down.

However I was able to download the files manually from the Epson site
from these URLs:
- http://support.epson.net/linux/src/scanner/iscan/iscan-data_1.39.2-1.tar.gz
- http://support.epson.net/linux/src/scanner/iscan/iscan_2.30.4-2.tar.gz
Then I had to add these files to the Nix store manually with the following command:
```
nix store add-file <path>
```

Then nix was able to build the `epkowa` package easily. Normally the files would
have been downloaded automatically, but it's a nice workaround in unfortunate cases.
