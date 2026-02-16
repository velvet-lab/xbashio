#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# ------------------------------------------------------------------------------
# Exit the script with as failed with an optional error message.
#
# Arguments:
#   $1 Error message (optional)
# ------------------------------------------------------------------------------
function devoxio::exit.nok() {
    local message=${1:-}

    devoxio::log.trace "${FUNCNAME[0]}:" "$@"

    if devoxio::var.has_value "${message}"; then
        devoxio::log.fatal "${message}"
    fi

    exit "${__DEVOXIO_EXIT_NOK}"
}

# ------------------------------------------------------------------------------
# Exit the script when given value is false, with an optional error message.
#
# Arguments:
#   $1 Value to check if false
#   $2 Error message (optional)
# ------------------------------------------------------------------------------
function devoxio::exit.die_if_false() {
    local value=${1:-}
    local message=${2:-}

    devoxio::log.trace "${FUNCNAME[0]}:" "$@"

    if devoxio::var.false "${value}"; then
        devoxio::exit.nok "${message}"
    fi
}

# ------------------------------------------------------------------------------
# Exit the script nicely.
# ------------------------------------------------------------------------------
function devoxio::exit.ok() {
    devoxio::log.trace "${FUNCNAME[0]}" "$@"
    exit "${__DEVOXIO_EXIT_OK}"
}