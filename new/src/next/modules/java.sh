#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# ------------------------------------------------------------------------------
# Configures maven
#
# ------------------------------------------------------------------------------
devoxio::java.configureMaven() {
    local source_maven_config="${1:-}"

    devoxio::log.info "Configuring maven..."

    devoxio::log.info "Create maven home"
    rm -rf "${HOME}"/.m2
    mkdir -p "${HOME}"/.m2

    if devoxio::var.has_value "${source_maven_config}"; then
        devoxio::log.info "copy host configuration"

        cp -f "${source_maven_config}" "${HOME}"/.m2/
    fi

    chown -R "${USER}":"${USER}" "${HOME}"/.m2
}

# ------------------------------------------------------------------------------
# Configures gradle
#
# ------------------------------------------------------------------------------
devoxio::java.configureGradle() {
    local source_gradle_config="${1:-}"

    devoxio::log.info "Configuring gradle..."

    devoxio::log.info "Create gradle home"
    rm -rf "${HOME}"/.m2
    mkdir -p "${HOME}"/.m2

    if devoxio::var.has_value "${source_maven_config}"; then
        devoxio::log.info "copy host configuration"

        cp -f "${source_maven_config}" "${HOME}"/.m2/
    fi

    chown -R "${USER}":"${USER}" "${HOME}"/.m2
}