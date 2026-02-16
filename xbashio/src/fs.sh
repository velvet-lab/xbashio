#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# ------------------------------------------------------------------------------
# Check whether or not a directory exists.
#
# Arguments:
#   $1 Path to directory
# ------------------------------------------------------------------------------
function xbashio::fs.directory_exists() {
    local directory=${1}

    xbashio::log.trace "${FUNCNAME[0]}:" "$@"

    if [[ -d "${directory}" ]]; then
        return "${__XBASHIO_EXIT_OK}"
    fi

    return "${__XBASHIO_EXIT_NOK}"
}

# ------------------------------------------------------------------------------
# Check whether or not a file exists.
#
# Arguments:
#   $1 Path to file
# ------------------------------------------------------------------------------
function xbashio::fs.file_exists() {
    local file=${1}

    xbashio::log.trace "${FUNCNAME[0]}:" "$@"

    if [[ -f "${file}" ]]; then
        return "${__XBASHIO_EXIT_OK}"
    fi

    return "${__XBASHIO_EXIT_NOK}"
}
