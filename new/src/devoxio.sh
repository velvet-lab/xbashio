#!/usr/bin/env bash
# -*- coding: utf-8 -*-

set -o errexit  # Exit script when a command exits with non-zero status
set -o errtrace # Exit on error inside any functions or sub-shells
set -o nounset  # Exit script on use of an undefined variable
set -o pipefail # Return exit status of the last command in the pipe that failed

# ==============================================================================
# GLOBALS
# ==============================================================================

# DEVOXIO version number
readonly DEVOXIO_VERSION="0.1.0"

# Stores the location of this library
readonly __DEVOXIO_LIB_DIR=$(dirname "${BASH_SOURCE[0]}")

source "${__DEVOXIO_LIB_DIR}/const.sh"

# Defaults
declare -g __DEVOXIO_LOG_LEVEL=${LOG_LEVEL:-${__DEVOXIO_DEFAULT_LOG_LEVEL}}
declare -g __DEVOXIO_LOG_FORMAT=${LOG_FORMAT:-${__DEVOXIO_DEFAULT_LOG_FORMAT}}
declare -g __DEVOXIO_LOG_TIMESTAMP=${LOG_TIMESTAMP:-${__DEVOXIO_DEFAULT_LOG_TIMESTAMP}}
declare -g __DEVOXIO_CACHE_DIR=${CACHE_DIR:-${__DEVOXIO_DEFAULT_CACHE_DIR}}
declare -g __DEVOXIO_MODULE_DIR=${MODULE_DIR:-${__DEVOXIO_DEFAULT_CACHE_DIR}}
declare -g __DEVOXIO_ETC_DIR=${ETC_DIR:-${__DEVOXIO_DEFAULT_ETC_DIR}}
declare -g __DEVOXIO_VAR_DIR=${ETC_DIR:-${__DEVOXIO_DEFAULT_VAR_DIR}}

# ==============================================================================
# Create folders
# ==============================================================================
mkdir -p "${__DEVOXIO_CACHE_DIR}"
mkdir -p "${__DEVOXIO_ETC_DIR}"
mkdir -p "${__DEVOXIO_VAR_DIR}"

chmod -R 750 "${__DEVOXIO_ETC_DIR}"
chmod -R 750 "${__DEVOXIO_VAR_DIR}"

# ==============================================================================
# Main Modules
# ==============================================================================
source "${__DEVOXIO_LIB_DIR}/color.sh"
source "${__DEVOXIO_LIB_DIR}/var.sh"
source "${__DEVOXIO_LIB_DIR}/fs.sh"
source "${__DEVOXIO_LIB_DIR}/log.sh"
source "${__DEVOXIO_LIB_DIR}/string.sh"
source "${__DEVOXIO_LIB_DIR}/exit.sh"

# ==============================================================================
# Other Modules
# ==============================================================================
source "${__DEVOXIO_LIB_DIR}/system.sh"
source "${__DEVOXIO_LIB_DIR}/apt.sh"
source "${__DEVOXIO_LIB_DIR}/security.sh"
# source "${__DEVOXIO_LIB_DIR}/ssh.sh"
source "${__DEVOXIO_LIB_DIR}/env.sh"

# ==============================================================================
# Extended Modules
# ==============================================================================
modules="${__DEVOXIO_LIB_DIR}/modules"
if [ -d "${modules}" ]; then
    for file in "${modules}"/*.sh; do
        chmod +x "${file}"
        source "${file}"
    done
fi

# ==============================================================================
# Load environment variables
# ==============================================================================
devoxio::env.load