#!/bin/bash

set -e

# the root directory (corresponds to the git)
ROOT=$(git rev-parse --show-toplevel)

echo -e "\n\e[1;34;1mTERMITE: building libcuud...\e[1;30;0m"
pushd ${ROOT}/lib/cudd > /dev/null
if [ "`getconf LONG_BIT`" == "64" ];
    then make -f Makefile.64bit libso
    else make -f Makefile.32bit libso
fi
popd > /dev/null

# get the environment variable
source ${ROOT}/envs.sh

# setting the cabal options to include the CUDD library
CABAL_OPTIONS="--extra-include-dirs=${LIB_CUDD}/include --extra-lib-dirs=${LIB_CUDD}/libso --bindir=${ROOT}/bin"

# for each of the required libraries, build it -- currently even if those are all dependencies
# for the termite-app, somehow just building the termite-app directly breaks the dependencies...
# (FIXME: make this work without building individually...)
for lib in util haskell_cudd bdd bv synthesis hast tsl gtksourceview code-widget graph-draw debug;
do
    echo -e "\n\e[1;34;1mTERMITE: building ${lib}...\e[1;30;0m"
    cabal v1-install  --force-reinstalls  ${ROOT}/lib/$lib ${CABAL_OPTIONS}
    echo -e "\e[0m"
done

# finally build termite, using the packages built above
echo -e "\n\e[1;34;1mTERMITE: building termite app...\e[1;30;0m"
cabal v1-install tools/termite-app --extra-include-dirs=${LIB_CUDD}/include --extra-lib-dirs=${LIB_CUDD}/libso --bindir=${ROOT}/bin
echo -e "\e[0m"

