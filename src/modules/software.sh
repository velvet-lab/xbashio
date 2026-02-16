#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# ------------------------------------------------------------------------------
# Loads the highest version of a software from GitHub
#
# Arguments:
#   $1 Github organization to look for the software
#   $2 Github repository to look for the software
# ------------------------------------------------------------------------------
xbashio::software.getVersion() {
    local org="${1:-}"
    local repository="${2:-}"

    version=$(curl -sSL -H "Accept: application/vnd.github.v3+json" "https://api.github.com/repos/${org}/${repository}/releases?per_page=1&page=1" | jq .[].tag_name | sed 's/"//g')

    return "${version}"
}

