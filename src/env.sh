#!/usr/bin/env bash
# -*- coding: utf-8 -*-


declare __XBASHIO_ENV_DIR="${__XBASHIO_VAR_DIR}"/environment

# ------------------------------------------------------------------------------
# Sets and saves environment variables
#
# Arguments:
#   $1 Keyname of the variable
#   $2 Value of the variable
# ------------------------------------------------------------------------------
xbashio::env.set() {
    local key="${1:-}"
    local value=${2:-}

    xbashio::log.trace "${FUNCNAME[0]}:"

    if xbashio::var.is_empty "${value}"; then
        xbashio::log.error "Value for key '${key}' is empty"
        return "${__XBASHIO_EXIT_NOK}"
    fi

    if ! xbashio::fs.directory_exists "${__XBASHIO_ENV_DIR}"; then
        mkdir -p "${__XBASHIO_ENV_DIR}"
    fi

    xbashio::log.info "Set environment variable '${key}' to '${value}'"
    export "${key}"="${value}"
    echo "${value}" > "${__XBASHIO_ENV_DIR}"/"${key}"

    return "${__XBASHIO_EXIT_OK}"
}

# ------------------------------------------------------------------------------
# Loads each file in environment folder and exports it
#
# ------------------------------------------------------------------------------
xbashio::env.load() {
    xbashio::log.trace "${FUNCNAME[0]}:"

    if ! xbashio::fs.directory_exists "${__XBASHIO_ENV_DIR}"; then
        return "${__XBASHIO_EXIT_OK}"
    fi

    local file
    for file in "${__XBASHIO_ENV_DIR}"/*; do
        local key
        local value

        [ -f "${file}" ] || continue

        key="$(basename "${file}")"
        value="$(cat "${file}")"
        if xbashio::var.is_empty "${value}"; then
            xbashio::log.warn "Value for key '${key}' is empty"
        fi
        export "${key}"="${value}"
    done

    return "${__XBASHIO_EXIT_OK}"
}
