#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# ------------------------------------------------------------------------------
# Configures python pip
#
# ------------------------------------------------------------------------------
devoxio::pip.configure(){

    local source_pip_config="${1:-}"

    devoxio::log.trace "${FUNCNAME[0]}:" "$@"
    devoxio::log.info "Configuring pip..."

    if devoxio::var.has_value "${source_pip_config}"; then
        devoxio::log.info "copy host configuration"
        rm -f "${HOME}"/.pip
        mkdir -p "${HOME}"/.pip
        cp -f "${source_npm_config}" "${HOME}"/.pip/pip.conf
        chown -R "${USER}":"${USER}" "${HOME}"/.pip
    fi

    return "${__DEVOXIO_EXIT_OK}"
}