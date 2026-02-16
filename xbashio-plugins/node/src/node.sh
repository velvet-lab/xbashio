#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# ------------------------------------------------------------------------------
# Installs nodejs packages global on system
#
# Arguments:
#   $1 Packages to install
# ------------------------------------------------------------------------------
xbashio::node.install(){
    local packages="$*"

    xbashio::log.trace "${FUNCNAME[0]}:" "$@"

    xbashio::log.info "Install global package '${packages}'"
    xbashio::env.export
    npm install -g "${packages}" || xbashio::exit.nok "Packages '$packages' could not installed"

    return "${__XBASHIO_EXIT_OK}"
}

# ------------------------------------------------------------------------------
# Configures nodejs
#
# Arguments:
#   $1 Path to .npmrc file for copying to local userprofile
# ------------------------------------------------------------------------------
xbashio::node.configure() {
    local source_npm_config="${1:-}"

    xbashio::log.trace "${FUNCNAME[0]}:" "$@"
    xbashio::log.info "Configuring nodejs..."

    if xbashio::var.has_value "${source_npm_config}"; then
        xbashio::log.info "copy host configuration"
        rm -f "${HOME}"/.npmrc
        cp -f "${source_npm_config}" "${HOME}"/.npmrc
        chown "${USER}":"${USER}" "${HOME}"/.npmrc
    fi

    if [ -d "${HOME}"/.npm ]; then
        xbashio::log.info "Change owner for .npm home"
        chown -R "${USER}":"${USER}" "${HOME}"/.npm
    fi

    xbashio::log.info "Configure npm"
    npm config delete prefix
    npm config set prefer-offline true
    npm config set maxsockets 4
    npm config set fetch-retries 4
    npm config set loglevel info
    npm config set prefix "${HOME}"/.local
    npm config set cache "${HOME}"/.npm
    npm config set legacy-peer-deps true
    npm config fix

    xbashio::log.info "Node.js configured"
    return "${__XBASHIO_EXIT_OK}"
}