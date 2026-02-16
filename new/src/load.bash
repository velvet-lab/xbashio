# Only for bats tests loading
export __DEVOXIO_LIB_DIR

__DEVOXIO_LIB_DIR=$(dirname "${BASH_SOURCE[0]}")

# Include devoxio library
source "${__DEVOXIO_LIB_DIR}/devoxio.sh"

