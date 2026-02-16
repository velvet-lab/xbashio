#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# ------------------------------------------------------------------------------
# Configures powershell and register artifactory as Gallery
#
# ------------------------------------------------------------------------------
devoxio::pwsh.configure(){

    devoxio::log.trace "${FUNCNAME[0]}:" "$@"
    devoxio::log.info "Configure powershell repository"
    pwsh -nol -nop -c ". /usr/lib/devoxio/modules/pwsh.ps1"

    devoxio::log.info "Powershell repository configured"
    return "${__DEVOXIO_EXIT_OK}"
}