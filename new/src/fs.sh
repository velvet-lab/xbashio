#!/usr/bin/env bash


# ------------------------------------------------------------------------------
# Check whether or not a directory exists.
#
# Arguments:
#   $1 Path to directory
# ------------------------------------------------------------------------------
function devoxio::fs.directory_exists() {
    local directory=${1}

    devoxio::log.trace "${FUNCNAME[0]}:" "$@"

    if [[ -d "${directory}" ]]; then
        return "${__DEVOXIO_EXIT_OK}"
    fi

    return "${__DEVOXIO_EXIT_NOK}"
}

# ------------------------------------------------------------------------------
# Check whether or not a file exists.
#
# Arguments:
#   $1 Path to file
# ------------------------------------------------------------------------------
function devoxio::fs.file_exists() {
    local file=${1}

    devoxio::log.trace "${FUNCNAME[0]}:" "$@"

    if [[ -f "${file}" ]]; then
        return "${__DEVOXIO_EXIT_OK}"
    fi

    return "${__DEVOXIO_EXIT_NOK}"
}
