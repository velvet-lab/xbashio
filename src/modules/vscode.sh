#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# ------------------------------------------------------------------------------
# Installs vscode Extensions
#
# ------------------------------------------------------------------------------
xbashio::vscode.install(){

    xbashio::log.trace "${FUNCNAME[0]}:" "$@"

    xbashio::log.info "install vscode extensions"
    pwsh -nol -nop -c ". /usr/lib/xbashio/modules/vscode.ps1"

    return "${__XBASHIO_EXIT_OK}"
}