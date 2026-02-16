#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# ------------------------------------------------------------------------------
# Configures powershell and register artifactory as Gallery
#
# ------------------------------------------------------------------------------
xbashio::pwsh.configure(){

    xbashio::log.trace "${FUNCNAME[0]}:" "$@"
    xbashio::log.info "Configure powershell repository"
    pwsh -nol -nop -c ". /usr/lib/xbashio/modules/pwsh.ps1"

    xbashio::log.info "Powershell repository configured"
    return "${__XBASHIO_EXIT_OK}"
}