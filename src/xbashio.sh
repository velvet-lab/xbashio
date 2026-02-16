#!/usr/bin/env bash
# -*- coding: utf-8 -*-

set -o errexit  # Exit script when a command exits with non-zero status
set -o errtrace # Exit on error inside any functions or sub-shells
set -o nounset  # Exit script on use of an undefined variable
set -o pipefail # Return exit status of the last command in the pipe that failed

# ==============================================================================
# GLOBALS
# ==============================================================================

# XBASHIO version number
readonly XBASHIO_VERSION="0.1.0"

# Stores the location of this library
readonly __XBASHIO_LIB_DIR=$(dirname "${BASH_SOURCE[0]}")

source "${__XBASHIO_LIB_DIR}/const.sh"

# Defaults
declare -g __XBASHIO_LOG_LEVEL=${LOG_LEVEL:-${__XBASHIO_DEFAULT_LOG_LEVEL}}
declare -g __XBASHIO_LOG_FORMAT=${LOG_FORMAT:-${__XBASHIO_DEFAULT_LOG_FORMAT}}
declare -g __XBASHIO_LOG_TIMESTAMP=${LOG_TIMESTAMP:-${__XBASHIO_DEFAULT_LOG_TIMESTAMP}}
declare -g __XBASHIO_CACHE_DIR=${CACHE_DIR:-${__XBASHIO_DEFAULT_CACHE_DIR}}
declare -g __XBASHIO_MODULE_DIR=${MODULE_DIR:-${__XBASHIO_DEFAULT_CACHE_DIR}}
declare -g __XBASHIO_ETC_DIR=${ETC_DIR:-${__XBASHIO_DEFAULT_ETC_DIR}}
declare -g __XBASHIO_VAR_DIR=${ETC_DIR:-${__XBASHIO_DEFAULT_VAR_DIR}}

# ==============================================================================
# Create folders
# ==============================================================================
mkdir -p "${__XBASHIO_CACHE_DIR}"
mkdir -p "${__XBASHIO_ETC_DIR}"
mkdir -p "${__XBASHIO_VAR_DIR}"

chmod -R 750 "${__XBASHIO_ETC_DIR}"
chmod -R 750 "${__XBASHIO_VAR_DIR}"

# ==============================================================================
# Main Modules
# ==============================================================================
source "${__XBASHIO_LIB_DIR}/color.sh"
source "${__XBASHIO_LIB_DIR}/var.sh"
source "${__XBASHIO_LIB_DIR}/fs.sh"
source "${__XBASHIO_LIB_DIR}/log.sh"
source "${__XBASHIO_LIB_DIR}/string.sh"
source "${__XBASHIO_LIB_DIR}/exit.sh"

# ==============================================================================
# Other Modules
# ==============================================================================
source "${__XBASHIO_LIB_DIR}/system.sh"
source "${__XBASHIO_LIB_DIR}/apt.sh"
source "${__XBASHIO_LIB_DIR}/security.sh"
# source "${__XBASHIO_LIB_DIR}/ssh.sh"
source "${__XBASHIO_LIB_DIR}/env.sh"

# ==============================================================================
# Extended Modules
# ==============================================================================
modules="${__XBASHIO_LIB_DIR}/modules"
if [ -d "${modules}" ]; then
    for file in "${modules}"/*.sh; do
        chmod +x "${file}"
        source "${file}"
    done
fi

# ==============================================================================
# Load environment variables
# ==============================================================================
xbashio::env.load