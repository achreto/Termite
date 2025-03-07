# Fork of the Termite Driver Synthesis Tool

This project was forked from [Termite2](https://github.com/termite2) and made run again for
more recent build environments.

## Docker

We provide a docker image to facilitate the process. See the `docker` directory. One can simply
execute :
```
    $ bash docker/docker-run.sh
```
This will then build a docker image for building Termite, starts the container and drops the
user into a shell with the source directory mounted.

Note: to run Termite, you will need to install the running dependencies

## Dependencies (Building)

Currently, we have tested the build process on Ubuntu 20.04. The following dependencies
are required to build Termite2.

Tools
```
    # apt-get install -y git z3 graphviz
```

Libraries
```
    # apt-get install -y libglib2.0-dev libcairo2-dev libpangocairo-1.0 libgtk2.0-dev \
                         libpango1.0-dev libgtksourceview2.0-dev libgtksourceview2.0-dev
```

Haskell related dependencies
```
    # apt-get install -y  ghc cabal-install libghc-cairo-dev libghc-glib-dev libghc-gtk-dev
```

## Dependencies (Running)

Dependencies for running Termite
```
    # apt-get install -y libcanberra-gtk-module libcanberra-gtk3-module libffi7 libgtksourceview2.0-dev
```
## Building

We provide a script to setup the build environment. For this, execute `bash setup.sh`.
This script initializes the git submodules, performs a cabal update and finally installs
the required cabal packages.

We currently still use the Cabal v1 way of building the packages.

To build Termite2 execute

```
    $ bash setup.sh
```

This will build all dependencies etc individually.

Note, building libcudd in the docker container
may fail if there is a mismatch between the supported microarchitectures of the compiler in
the container, and your host machine.

To build CUDD:
```
    $ pushd lib/cudd
    $ cp Makefile.64bit Makefile # or Makefile.32bit if you are on a 32 bit system
    $ make libso
    $ popd
```

## Running

Copy the language definition to a place where GTKSourceView can find it:

```
    # sudo cp lib/tsl/tools/tsl.lang /usr/share/gtksourceview-2.0/language-specs/
```

To run:
```
    $ source ./envs.sh
    $ cd documentation/GPIO
    $ ../../bin/termite -i main.tsl -s
```
