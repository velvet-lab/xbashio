#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# ------------------------------------------------------------------------------
# Updates the Package Cache
#
# ------------------------------------------------------------------------------
devoxio::apt.update() {

    devoxio::log.trace "${FUNCNAME[0]}:"

    export DEBIAN_FRONTEND=noninteractive

    devoxio::log.info "Update package cache"
    apt-get update || devoxio::exit.nok "Package cache could not updated"
    return "${__DEVOXIO_EXIT_OK}"
}

# ------------------------------------------------------------------------------
# Upgrade the System
#
# ------------------------------------------------------------------------------
devoxio::apt.upgrade() {

    devoxio::log.trace "${FUNCNAME[0]}:"

    devoxio::log.info "Upgrade system"

    export DEBIAN_FRONTEND=noninteractive

    devoxio::apt.update
    apt-get upgrade -qy --no-install-recommends || devoxio::exit.nok "System could not upgraded"
    return "${__DEVOXIO_EXIT_OK}"
}

# ------------------------------------------------------------------------------
# Installs given Packages
#
# Arguments:
#   $1 Package to install
# ------------------------------------------------------------------------------
devoxio::apt.install() {
    local packages="$*"

    devoxio::log.trace "${FUNCNAME[0]}:" "$@"

    devoxio::log.info "Install package '${packages}' on system"

    export DEBIAN_FRONTEND=noninteractive

    # shellcheck disable=SC2086
    apt-get install -qy --no-install-recommends ${packages}  || devoxio::exit.nok "Packages '$packages' could not installed"
    return "${__DEVOXIO_EXIT_OK}"
}

# ------------------------------------------------------------------------------
# Removes given Packages
#
# Arguments:
#   $1 Package to remove
# ------------------------------------------------------------------------------
devoxio::apt.remove() {
    local packages="$*"

    devoxio::log.trace "${FUNCNAME[0]}:" "$@"

    devoxio::log.info "Remove package '${packages}' on system"

    export DEBIAN_FRONTEND=noninteractive

    # shellcheck disable=SC2086
    apt-get purge -qy --no-install-recommends ${packages} || devoxio::exit.nok "Packages 'packages' could not removed"
    return "${__DEVOXIO_EXIT_OK}"
}

# ------------------------------------------------------------------------------
# Install minimum default to system
#
# ------------------------------------------------------------------------------
devoxio::apt.prepare() {
    local packages="sudo nano apt-transport-https openssl dos2unix"

    devoxio::log.trace "${FUNCNAME[0]}:" "$@"

    devoxio::log.info "Install minimum packages '${packages}' on system"

    export DEBIAN_FRONTEND=noninteractive

    devoxio::apt.update
    # shellcheck disable=SC2086
    apt-get install -qy --no-install-recommends ${packages} || devoxio::exit.nok "System could not prepared"
    return "${__DEVOXIO_EXIT_OK}"
}

# ------------------------------------------------------------------------------
# Cleanup system caches
#
# ------------------------------------------------------------------------------
devoxio::apt.clean() {

    devoxio::log.trace "${FUNCNAME[0]}:" "$@"

    devoxio::log.info "Cleanup system"

    export DEBIAN_FRONTEND=noninteractive

    # see https://askubuntu.com/questions/1433449/how-to-unlock-var-cache-apt-archives-lock
    (apt-get autoremove -qy \
        && apt-get clean -qy \
        && rm -f /var/lib/apt/lists/lock || true \
        && rm -f /var/cache/apt/archives/lock || true \
        && rm -f /var/lib/dpkg/lock || true \
        && rm -rf /var/lib/apt/lists/* \
        && rm -rf /var/cache/apt/archives/partial/* \
        && rm -rf /root/.cache) \
         || devoxio::exit.nok "System could not cleaned"

    return "${__DEVOXIO_EXIT_OK}"
}