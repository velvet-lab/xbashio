# Only for bats tests loading
export __XBASHIO_LIB_DIR

__XBASHIO_LIB_DIR=$(dirname "${BASH_SOURCE[0]}")

# Load xbashio library
load "${__XBASHIO_LIB_DIR}/node_modules/bats-support/load"
load "${__XBASHIO_LIB_DIR}/node_modules/bats-assert/load"

# Include xbashio library
# shellcheck source=./xbashio-core/src/xbashio.sh
source "${__XBASHIO_LIB_DIR}/src/xbashio.sh"
