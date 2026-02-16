#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# ------------------------------------------------------------------------------
# Checks if a given value is true.
#
# Arguments:
#   $1 value
# ------------------------------------------------------------------------------
function devoxio::var.true() {
    local value=${1:-null}

    devoxio::log.trace "${FUNCNAME[0]}:" "$@"

    if [[ "${value}" = "true" ]] || [[ "${value}" = 1 ]]; then
        return "${__DEVOXIO_EXIT_OK}"
    fi

    return "${__DEVOXIO_EXIT_NOK}"
}

# ------------------------------------------------------------------------------
# Checks if a give value is false.
#
# Arguments:
#   $1 value
# ------------------------------------------------------------------------------
function devoxio::var.false() {
    local value=${1:-null}

    devoxio::log.trace "${FUNCNAME[0]}:" "$@"

    if [[ "${value}" = "false" ]] || [[ "${value}" = 0 ]]; then
        return "${__DEVOXIO_EXIT_OK}"
    fi

    return "${__DEVOXIO_EXIT_NOK}"
}

# ------------------------------------------------------------------------------
# Checks if a global variable is defined.
#
# Arguments:
#   $1 Name of the variable
# ------------------------------------------------------------------------------
devoxio::var.defined() {
    local variable=${1}

    devoxio::log.trace "${FUNCNAME[0]}:" "$@"

    [[ "${!variable-X}" = "${!variable-Y}" ]]
}

# ------------------------------------------------------------------------------
# Checks if a value has actual value.
#
# Arguments:
#   $1 Value
# ------------------------------------------------------------------------------
function devoxio::var.has_value() {
    local value=${1}

    devoxio::log.trace "${FUNCNAME[0]}:" "$@"

    if [[ -n "${value}" ]]; then
        return "${__DEVOXIO_EXIT_OK}"
    fi

    return "${__DEVOXIO_EXIT_NOK}"
}

# ------------------------------------------------------------------------------
# Checks if a value is empty.
#
# Arguments:
#   $1 Value
# ------------------------------------------------------------------------------
function devoxio::var.is_empty() {
    local value=${1}

    devoxio::log.trace "${FUNCNAME[0]}:" "$@"

    if [[ -z "${value}" ]]; then
        return "${__DEVOXIO_EXIT_OK}"
    fi

    return "${__DEVOXIO_EXIT_NOK}"
}

# ------------------------------------------------------------------------------
# Checks if a value equals.
#
# Arguments:
#   $1 Value
#   $2 Equals value
# ------------------------------------------------------------------------------
function devoxio::var.equals() {
    local value=${1}
    local equals=${2}

    devoxio::log.trace "${FUNCNAME[0]}:" "$@"

    if [[ "${value}" = "${equals}" ]]; then
        return "${__DEVOXIO_EXIT_OK}"
    fi

    return "${__DEVOXIO_EXIT_NOK}"
}
