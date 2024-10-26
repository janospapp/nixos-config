# Summary

In a conventional distro I'd use rbenv to set up ruby and the gems and
use `docker-compose` to manage extra services (i.e. postgres, redis, etc.).

In NixOS I found a few different ways to manage development environments,
that I document here. Not all led to success for me setting up a rails
project (which is mainly due to my inexperience with NixOS).

Below I document what approaches I tried and how far I got. Just as a
reference for my future self.

# Distrobox

Distrobox is a generic tool that can be used on any distro. It spins up a
containerized environment of the given linux distribution. In the background
it starts a container but applies a few convenience layers on top of it:
* Automatically mount certain system paths, i.e. your `/home`, `/media`, `/mnt`,
  and other folders. However it uses it's own root filesystem, so installing
  new packages won't pollute your main system.
* Has a convenient CLI that helps to manage these containers and environments.
* I haven't checked but they are supposed to integrate well with graphical
  applications.
* Uses your normal user instead of root (this might be because of using podman
  instead of docker as a backend...)

The official [NixOS install page](https://wiki.nixos.org/wiki/Distrobox) worked
for installing distrobox.

## Setup

Create a new environment with
```shell
> distrobox create --name rails-test
```
By default it offered a Fedora 39 toolbox which fits my need well. Maybe
a different image already contained the necessary tools pre-installed. The
image can be defined with the `--image <label>` parameter.

Once it's created, enter the environment with
```shell
> distrobox enter rails-test
```

Install the required packages
```shell
> sudo dnf install make gcc ruby-devel
> gem install rails
> ~/bin/rails new hello-rails -d postgresql -T -c tailwind
```
For some reason after the rails gem installation the binstub was not automatically
available, so I had to run it form ~/bin to access the rails executable.

After this `bundle install` failed miserably, as it wanted to write into the system's
`/usr/share` folder.

I stopped at this step. It seems installing ruby and the gems system wide is not a
good idea. I should go with my standard `rbenv` installation instead. However it needs
to hook into my `.zshrc` which is managed by NixOS, and `rbenv` wouldn't be available
outside this environment, so adding it to my main `.zshrc` is also not a good idea.

Maybe there's a way to manage gems in the user space easily, I just don't know how, and
don't want to waste time on figuring out this setup (maybe at a later time).

I cleaned up the installation from my home folder by
```shell
> rm ~/bin/*
> rm -rf ~/.local/share/gem
```

# Nix dev shell

Nix dev shells are the standard environments for development. They allow us to install
different toolchains and packages that are limited for that session and not exposed in
the standard system. They are usually combined with [direnv](https://github.com/nix-community/nix-direnv)
that automatically activates the environment when we `cd` into the project folder. When
we move to another folder, the environment gets deactivated.

Most dev shell tutorials describe the non-flake way, where we define the environment in
`shell.nix` and activate it with `nix-shell`. However as I use flakes, I have a `flake.nix`
which could be activated with the `nix develop` command, but as I use `direnv` it activates
the environment for me, and updates it whenever my `flake.nix` file changes.

For flake direnvs, it's enough to put `use flake` in the `.envrc` file and run `direnv allow`.

For `flake.nix` we need a `devShells.<system>.default` output that can be created with the
`mkShell` utility.

I try two different approach to set up rails. One is use only `ruby` from NixOS and try to
install gems imperatively using `gem` and `bundler`. The other is the officially suggested
way, to use `bundix`, which is kind of a nixified bundler. It takes all the gems, wrap them
in small nix packages and puts them in the store.

## Standard bundler

I have the following `flake.nix` file:
```
{
  description = "A ruby environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
    devShells.x86_64-linux.default = pkgs.mkShell {
      packages = with pkgs; [ libyaml postgresql ruby ];

      shellHook = ''
        echo "Welcome to `${pkgs.ruby}/bin/ruby --version`"
      '';
    };
  };
}
```

### Install rails

The above flake exposes a standard ruby environment, so we can install the `rails` gem, with
```shell
> gem install rails
```
It installs the gems and bin stubs in `~/.local/share/gem/ruby/3.3.0`, so we can
generate our rails project with
```shell
~/.local/share/gem/ruby/3.3.0/bin/rails new . -d postgresql -T -c tailwind
```

**Note**: After the rails project is generated (which initializes a git repository), nix will
complain that the `flake.nix` file is not found in the store. This happens until we start to
track the files in git's staging area, i.e. run `git add .`. Then the flake builds just fine.

### Start the server

Bin stubs are still not available, so we either run rails via `bundle exec rails` or `./bin/rails`.

In order to have the app running, we'll need a running database. I didn't set up Postgresql on my
host, but went with a simple docker-compose setup. (I used podman-compose on my NixOS, but didn't
see any difference.)

Create the `docker-compose.yml` file:
```
volumes:
  db:

services:
  postgres:
    image: postgres:16-alpine
    volumes:
      - db:/var/lib/postgresql/data
    ports:
      - 5432:5432
    environment:
      - POSTGRES_PASSWORD=password
```
**Note**: This is only for development, don't expose your postgres password in production.

Also set the correct data in `config/database.yml`:
```
default: &default
  ...
  host: localhost
  port: 5432
  user: postgres
  password: password
```
**Note**: Don't use the default `postgres` user, it's betterr to create a dedicated user with just
enough permission to manage databases. Also, don't expose the password as clear text in the repo.

After this setup, the db should be started with `docker-compose up -d` or `podman-compose up -d`,
and also start the rails server `bin/rails s`. Visiting `localhost:3000` should show the default
rails homepage.

## Using bundix

This setup is quite similar to the above dev shell one, we just use `bundix` to manage the gems
through the nix store. We could take the above setup, and simply convert it to a bundix project,
as most tutorials show how to do it for an existing project with `Gemfile` and `Gemfile.lock`.

However for this use case, we'll start it from scratch, just for fun.

We'll start with a similar `flake.nix` as before, but we'll add `bundix` to the packages.
```
{
  description = "A ruby environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
    devShells.x86_64-linux.default = pkgs.mkShell {
      packages = with pkgs; [ bundix libyaml postgresql ruby ];

      shellHook = ''
        echo "Welcome to `${pkgs.ruby}/bin/ruby --version`"
      '';
    };
  };
}
```

After we allowed the folder for direnv and all tools are available, we'll use standard bundler
to generate an initial Gemfile for us:
```shell
> bundle init
```

**Note**: There is a [problem](https://github.com/NixOS/nixpkgs/issues/190084#issuecomment-1474757978)
with `bundix` for platform specific gems. Following the comment's suggestion I ran this command:
```shell
> bundle config set --local force_ruby_platform true
```
I don't understand entirely what it does, but it solved my build problem, that would occur otherwise
at a later step.

Even the empty Gemfile has `gem "rails"` commented. Uncomment that line, so our gemfile will
contain only `rails`. When this is done, bundix has a Gemfile to work with. Run the following
```shell
> bundix -l
```
The `-l` flag tells bundix to generate the Gemfile.lock first (it's not necessary for an existing
project, which already has the lock file). After this command you shall have `Gemfile.lock` and
`gemset.nix`. The latter contains packaging information for bundix. To make these gems available
we must add another input to our dev shell in `flake.nix`. It looks like this after the update:
```
{
  description = "A ruby environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
    devShells.x86_64-linux.default = pkgs.mkShell rec {
      gems = pkgs.bundlerEnv {
        name = "hello-rails";
        ruby = pkgs.ruby;
        gemdir = ./.;
      };
      packages = with pkgs; [ bundix gems libyaml postgresql ruby ];

      shellHook = ''
        echo "Welcome to `${pkgs.ruby}/bin/ruby --version`"
      '';
    };
  };
}
```
(I added the `gems` that is produced by calling `pkgs.bundlerEnv`.)

When this is saved, and our dev shell is updated, all our gems and bin stubs are packaged in the
nix store in the "hello-rails" package. We can continue generating our rails app:
```shell
rails new . -d postgresql -T -c tailwind
```

I let rails to override my Gemfile, but it led to some conflicts or build errors. I tried to delete
`Gemfile.lock` and `gemset.nix` and regenerate them with `bundix -l` but it failed at a different
point.

I stop here, don't debug it further. (Maybe creating a new project with bundix wasn't a good idea
after all. Or I missed a crucial step somewhere.)

## Devenv

To be continued ...
