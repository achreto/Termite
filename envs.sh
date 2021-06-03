# the root directory (corresponds to the git)
ROOT=$(git rev-parse --show-toplevel)

# export the library path
export LD_LIBRARY_PATH=${ROOT}/lib/cudd/libso
export LIB_CUDD=${ROOT}/lib/cudd
