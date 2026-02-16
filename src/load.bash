# Only for bats tests loading
export __XBASHIO_LIB_DIR

__XBASHIO_LIB_DIR=$(dirname "${BASH_SOURCE[0]}")

# Include xbashio library
source "${__XBASHIO_LIB_DIR}/xbashio.sh"
