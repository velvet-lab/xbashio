# Only for bats tests loading
export __XBASHIO_LIB_DIR

__XBASHIO_LIB_DIR=$(dirname "${BASH_SOURCE[0]}")

# Load xbashio library
load "$BATS_TEST_DIRNAME"/../node_modules/bats-support/load
load "$BATS_TEST_DIRNAME"/../node_modules/bats-assert/load

# Include xbashio library
source "${__XBASHIO_LIB_DIR}/src/xbashio.sh"
