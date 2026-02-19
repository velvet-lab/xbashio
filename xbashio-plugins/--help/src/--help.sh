#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# ------------------------------------------------------------------------------
# Example function for --help plugin
#
# Description:
#   Add your function description here
#
# Returns:
#   0 on success, non-zero on error
# ------------------------------------------------------------------------------
xbashio::--help.example() {

    xbashio::log.trace "${FUNCNAME[0]}:"

    xbashio::log.info "Example function for --help"

    # Add your implementation here

    return "${__XBASHIO_EXIT_OK}"
}
