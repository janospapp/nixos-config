# How to install and run abevjava on NixOS

It probably uses X11, so I need xwayland to be enabled:
`programs.xwayland.enable = true;`

It also has an official rpm package download, so I run it form a
Fedora VM using distrobox.

```shell
> distrobox enter my-fedora-ws
```

## Install the ANYK framework
Download from NAV's page, then
```shell
> sudo dnf install ./...rpm
```

## Install java 8

```shell
> sudo dnf install adoptium-temurin-java-repository
> sudo fedora-third-party enable
> dnf search temurin
> sudo dnf install temurin-8-jre.x86_64
```

## Check java version
```shell
> java -version
```

If it's not 1.8, switch the default
```shell
> sudo alternatives --config java
```

## Run the app
```shell
> cd /usr/share/abevjava
```

Set an enviornment variable to fix the rendering bug of the main page
```shell
> export _JAVA_AWT_WM_NONREPARENTING=1
```

Start the app
```shell
> java -jar ./abevjava.jar
```
