#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# ------------------------------------------------------------------------------
# Configures maven
#
# ------------------------------------------------------------------------------
xbashio::java.configureMaven() {
    local source_maven_config="${1:-}"

    xbashio::log.info "Configuring maven..."

    xbashio::log.info "Create maven home"
    rm -rf "${HOME}"/.m2
    mkdir -p "${HOME}"/.m2

    if xbashio::var.has_value "${source_maven_config}"; then
        xbashio::log.info "copy host configuration"

        cp -f "${source_maven_config}" "${HOME}"/.m2/
    fi

    chown -R "${USER}":"${USER}" "${HOME}"/.m2
}

# ------------------------------------------------------------------------------
# Configures gradle
#
# ------------------------------------------------------------------------------
xbashio::java.configureGradle() {
    local source_gradle_config="${1:-}"

    xbashio::log.info "Configuring gradle..."

    xbashio::log.info "Create gradle home"
    rm -rf "${HOME}"/.m2
    mkdir -p "${HOME}"/.m2

    if xbashio::var.has_value "${source_maven_config}"; then
        xbashio::log.info "copy host configuration"

        cp -f "${source_maven_config}" "${HOME}"/.m2/
    fi

    chown -R "${USER}":"${USER}" "${HOME}"/.m2
}