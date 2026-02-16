#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# ------------------------------------------------------------------------------
# Configures python pip
#
# ------------------------------------------------------------------------------
xbashio::pip.configure(){

    local source_pip_config="${1:-}"

    xbashio::log.trace "${FUNCNAME[0]}:" "$@"
    xbashio::log.info "Configuring pip..."

    if xbashio::var.has_value "${source_pip_config}"; then
        xbashio::log.info "copy host configuration"
        rm -f "${HOME}"/.pip
        mkdir -p "${HOME}"/.pip
        cp -f "${source_npm_config}" "${HOME}"/.pip/pip.conf
        chown -R "${USER}":"${USER}" "${HOME}"/.pip
    fi

    return "${__XBASHIO_EXIT_OK}"
}
