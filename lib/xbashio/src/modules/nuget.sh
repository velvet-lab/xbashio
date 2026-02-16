#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# ------------------------------------------------------------------------------
# Configures nuget
#
# ------------------------------------------------------------------------------
xbashio::nuget.configure() {
    local source_nuget_config="${1:-}"

    xbashio::log.info "Configuring nuget..."

    mkdir -p /vscode/artefacts
    chown -R "${USER}":"${USER}" /vscode/artefacts

    dotnet nuget remove source artefacts
    dotnet nuget add source --name artefacts /vscode/artefacts

    # create dotnet tools home
    mkdir -p "${HOME}"/.dotnet/tools
    chown -R "${USER}":"${USER}" "${HOME}"/.dotnet

    if xbashio::var.has_value "${source_npm_config}"; then
        xbashio::log.info "copy host configuration"

        mkdir -p "$HOME"/.nuget/NuGet
        cp -f "${source_nuget_config}" "${HOME}"/.nuget/NuGet
        chown -R "${USER}":"${USER}" "${HOME}"/.nuget
    fi
}