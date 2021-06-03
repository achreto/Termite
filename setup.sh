#!/bin/sh

set -e

# the root directory (corresponds to the git)
ROOT=$(git rev-parse --show-toplevel)

# initialize the submodules
echo -e "\n\e[1;34;1mTERMITE: initializing submodules...\e[1;30;0m"
git submodule init
git submodule update

# not using the sandbox for now...
# echo -e "\n\e[1;34;1mTERMITE: creating cabal sandbox...\e[1;30;0m"
# cabal v1-sandbox init
# cabal v1-sandbox add-source lib/bdd lib/bv lib/code-widget lib/debug lib/graph-draw \
#                             lib/haskell_cudd lib/hast lib/synthesis lib/tsl lib/util \
#                             lib/gtksourceview tools/termite-app

# performa Cabal update
echo -e "\n\e[1;34;1mTERMITE: updating cabal...\e[1;30;0m"
cabal v1-update

# install the required Cabal packages
echo -e "\n\e[1;34;1mTERMITE: installing happy alex..\e[1;30;0m"
cabal v1-install happy alex

# let's install some packages with specific versions now, so we don't end up in version
# conflicts later...
echo -e "\n\e[1;34;1mTERMITE: installing some cabal packages to fix the version..\e[1;30;0m"
cabal v1-install containers-0.6.0.1
cabal v1-install binary-0.8.8.0
cabal v1-install text-1.2.4.1
cabal v1-install Cabal-3.2.1.0

# now install some of the pre-requisite tools to build termite
echo -e "\n\e[1;34;1mTERMITE: installing pre-requisites..\e[1;30;0m"
cabal v1-install c2hs-0.28.7
cabal v1-install gtk2hs-buildtools-0.13.8.0
echo -e "\e[0m"
