#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# ------------------------------------------------------------------------------
# Installs vscode Extensions
#
# ------------------------------------------------------------------------------
devoxio::vscode.install(){

    devoxio::log.trace "${FUNCNAME[0]}:" "$@"

    devoxio::log.info "install vscode extensions"
    pwsh -nol -nop -c ". /usr/lib/devoxio/modules/vscode.ps1"

    return "${__DEVOXIO_EXIT_OK}"
}