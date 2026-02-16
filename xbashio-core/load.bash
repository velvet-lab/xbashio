# Only for bats tests loading
export __XBASHIO_LIB_DIR

__XBASHIO_LIB_DIR=$(dirname "${BASH_SOURCE[0]}")

# Try to find node_modules in this dir or up to 3 parents using find
__XBASHIO_NODE_MODULES_DIR="$(find \
  "${__XBASHIO_LIB_DIR}" \
  "${__XBASHIO_LIB_DIR}/.." \
  "${__XBASHIO_LIB_DIR}/../.." \
  "${__XBASHIO_LIB_DIR}/../../.." \
  -maxdepth 1 -type d -name 'node_modules' -print -quit 2>/dev/null || true)"

# Fallback to original value if nothing found
if [[ -z "${__XBASHIO_NODE_MODULES_DIR}" ]]; then
  __XBASHIO_NODE_MODULES_DIR="${__XBASHIO_LIB_DIR}/node_modules"
fi

if [ ! -d "${__XBASHIO_NODE_MODULES_DIR}" ]; then
    echo "Error: node_modules directory not found at ${__XBASHIO_NODE_MODULES_DIR}"
    exit 1
fi

# Load xbashio library
load "${__XBASHIO_NODE_MODULES_DIR}/bats-support/load"
load "${__XBASHIO_NODE_MODULES_DIR}/bats-assert/load"

# Include xbashio library
# shellcheck source=./xbashio-core/src/xbashio.sh
source "${__XBASHIO_LIB_DIR}/src/xbashio.sh"
