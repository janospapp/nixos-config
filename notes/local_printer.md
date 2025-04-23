# Setting up my USB printer

I wasn't sure if I needed CUPS enabled or not for local
printers. I know it enabled network printing services,
and it had a vulnerability recently, so I was not sure if
I need to keep it or not. I don't know much about the Linux
printer stacks, so eventually I kept it enabled.

I also added the `hplip` driver which seemed a generic
driver for HP printers.

Finally I used the KDE's `Printers` settings to set up my
printer. As a driver I went for HP drivers directly, and
selected the type and hpcups driver. Then the printer
worked normally. Probably I can set up the printer from
my NixOS config directly (`hardware.printers`), btut I didn't
have the time to figure it out.

## Printer is not detected

At another installation KDE Printers couldn't detect the printer
automatically. I tried to set the `ipps://` URI from a working
setup, but it did not work. I also tried different combinations
of the addres with static IP, but all attempts failed.

Eventually I could add the printer using CLI:
```
lpadmin -p HP_M15w -E -v ipp://<printer IP>/ipp/print -m everywhere
```
