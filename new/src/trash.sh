#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# ------------------------------------------------------------------------------
# Cleans the System after run
#
# ------------------------------------------------------------------------------
function devoxio::trash.clean() {

    devoxio::log.trace "${FUNCNAME[0]}:"

    devoxio::log.info "Cleanup System"
    devoxio::security.clean
    devoxio::ssh.clean

    devoxio::log.info "System cleaned."

    return "${__DEVOXIO_EXIT_OK}"
}