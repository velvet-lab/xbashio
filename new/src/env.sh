#!/usr/bin/env bash
# -*- coding: utf-8 -*-


declare __DEVOXIO_ENV_DIR="${__DEVOXIO_VAR_DIR}"/environment

# ------------------------------------------------------------------------------
# Sets and saves environment variables
#
# Arguments:
#   $1 Keyname of the variable
#   $2 Value of the variable
# ------------------------------------------------------------------------------
devoxio::env.set() {
    local key="${1:-}"
    local value=${2:-}

    devoxio::log.trace "${FUNCNAME[0]}:"

    if devoxio::var.is_empty "${value}"; then
        devoxio::log.error "Value for key '${key}' is empty"
        return "${__DEVOXIO_EXIT_NOK}"
    fi

    if ! devoxio::fs.directory_exists "${__DEVOXIO_ENV_DIR}"; then
        mkdir -p "${__DEVOXIO_ENV_DIR}"
    fi

    devoxio::log.info "Set environment variable '${key}' to '${value}'"
    export "${key}"="${value}"
    echo "${value}" > "${__DEVOXIO_ENV_DIR}"/"${key}"

    return "${__DEVOXIO_EXIT_OK}"
}

# ------------------------------------------------------------------------------
# Loads each file in environment folder and exports it
#
# ------------------------------------------------------------------------------
devoxio::env.load() {
    devoxio::log.trace "${FUNCNAME[0]}:"

    if ! devoxio::fs.directory_exists "${__DEVOXIO_ENV_DIR}"; then
        return "${__DEVOXIO_EXIT_OK}"
    fi

    local file
    for file in "${__DEVOXIO_ENV_DIR}"/*; do
        local key
        local value

        [ -f "${file}" ] || continue

        key="$(basename "${file}")"
        value="$(cat "${file}")"
        if devoxio::var.is_empty "${value}"; then
            devoxio::log.warn "Value for key '${key}' is empty"
        fi
        export "${key}"="${value}"
    done

    return "${__DEVOXIO_EXIT_OK}"
}
