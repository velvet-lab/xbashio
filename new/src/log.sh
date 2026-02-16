#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# ------------------------------------------------------------------------------
# Log a message to output.
#
# Arguments:
#   $1 Message to display
# ------------------------------------------------------------------------------
devoxio::log() {
    local message=$*
    echo -e "${message}" >&2
    return "${__DEVOXIO_EXIT_OK}"
}

# ------------------------------------------------------------------------------
# Log a message to output (in red).
#
# Arguments:
#   $1 Message to display
# ------------------------------------------------------------------------------
devoxio::log.red() {
    local message=$*
    echo -e "${__DEVOXIO_COLORS_RED}${message}${__DEVOXIO_COLORS_RESET}" >&2
    return "${__DEVOXIO_EXIT_OK}"
}

# ------------------------------------------------------------------------------
# Log a message to output (in green).
#
# Arguments:
#   $1 Message to display
# ------------------------------------------------------------------------------
devoxio::log.green() {
    local message=$*
    echo -e "${__DEVOXIO_COLORS_GREEN}${message}${__DEVOXIO_COLORS_RESET}" >&2
    return "${__DEVOXIO_EXIT_OK}"
}

# ------------------------------------------------------------------------------
# Log a message to output (in yellow).
#
# Arguments:
#   $1 Message to display
# ------------------------------------------------------------------------------
devoxio::log.yellow() {
    local message=$*
    echo -e "${__DEVOXIO_COLORS_YELLOW}${message}${__DEVOXIO_COLORS_RESET}" >&2
    return "${__DEVOXIO_EXIT_OK}"
}

# ------------------------------------------------------------------------------
# Log a message to output (in blue).
#
# Arguments:
#   $1 Message to display
# ------------------------------------------------------------------------------
devoxio::log.blue() {
    local message=$*
    echo -e "${__DEVOXIO_COLORS_BLUE}${message}${__DEVOXIO_COLORS_RESET}" >&2
    return "${__DEVOXIO_EXIT_OK}"
}

# ------------------------------------------------------------------------------
# Log a message to output (in magenta).
#
# Arguments:
#   $1 Message to display
# ------------------------------------------------------------------------------
devoxio::log.magenta() {
    local message=$*
    echo -e "${__DEVOXIO_COLORS_MAGENTA}${message}${__DEVOXIO_COLORS_RESET}" >&2
    return "${__DEVOXIO_EXIT_OK}"
}

# ------------------------------------------------------------------------------
# Log a message to output (in cyan).
#
# Arguments:
#   $1 Message to display
# ------------------------------------------------------------------------------
devoxio::log.cyan() {
    local message=$*
    echo -e "${__DEVOXIO_COLORS_CYAN}${message}${__DEVOXIO_COLORS_RESET}" >&2
    return "${__DEVOXIO_EXIT_OK}"
}

# ------------------------------------------------------------------------------
# Log a message using a log level.
#
# Arguments:
#   $1 Log level
#   $2 Message to display
# ------------------------------------------------------------------------------
function devoxio::log.log() {
    local level=${1}
    local message=${2}
    local timestamp
    local output

    devoxio::log.init

    if [[ "${level}" -gt "${__DEVOXIO_LOG_LEVEL}" ]]; then
        return "${__DEVOXIO_EXIT_OK}"
    fi

    timestamp=$(date +"${__DEVOXIO_LOG_TIMESTAMP}")

    output="${__DEVOXIO_LOG_FORMAT}"
    output="${output//\{TIMESTAMP\}/${timestamp}}"
    output="${output//\{MESSAGE\}/${message}}"
    output="${output//\{LEVEL\}/${__DEVOXIO_LOG_LEVELS[$level]}}"

    echo -e "${output}" >&2

    return "${__DEVOXIO_EXIT_OK}"
}

# ------------------------------------------------------------------------------
# Log a message @ trace level.
#
# Arguments:
#   $* Message to display
# ------------------------------------------------------------------------------
function devoxio::log.trace() {
    local message=$*
    devoxio::log.log "${__DEVOXIO_LOG_LEVEL_TRACE}" "${message}"
}

# ------------------------------------------------------------------------------
# Log a message @ debug level.
#
# Arguments:
#   $* Message to display
# ------------------------------------------------------------------------------
function devoxio::log.debug() {
    local message=$*
    devoxio::log.log "${__DEVOXIO_LOG_LEVEL_DEBUG}" "${message}"
}

# ------------------------------------------------------------------------------
# Log a message @ info level.
#
# Arguments:
#   $* Message to display
# ------------------------------------------------------------------------------
function devoxio::log.info() {
    local message=$*
    devoxio::log.log \
        "${__DEVOXIO_LOG_LEVEL_INFO}" \
        "${__DEVOXIO_COLORS_GREEN}${message}${__DEVOXIO_COLORS_RESET}"
}

# ------------------------------------------------------------------------------
# Log a message @ notice level.
#
# Arguments:
#   $* Message to display
# ------------------------------------------------------------------------------
function devoxio::log.notice() {
    local message=$*
    devoxio::log.log \
        "${__DEVOXIO_LOG_LEVEL_NOTICE}" \
        "${__DEVOXIO_COLORS_CYAN}${message}${__DEVOXIO_COLORS_RESET}"
}

# ------------------------------------------------------------------------------
# Log a message @ warning level.
#
# Arguments:
#   $* Message to display
# ------------------------------------------------------------------------------
function devoxio::log.warning() {
    local message=$*
    devoxio::log.log \
        "${__DEVOXIO_LOG_LEVEL_WARNING}" \
        "${__DEVOXIO_COLORS_YELLOW}${message}${__DEVOXIO_COLORS_RESET}"
}

# ------------------------------------------------------------------------------
# Log a message @ error level.
#
# Arguments:
#   $* Message to display
# ------------------------------------------------------------------------------
function devoxio::log.error() {
    local message=$*
    devoxio::log.log \
        "${__DEVOXIO_LOG_LEVEL_ERROR}" \
        "${__DEVOXIO_COLORS_MAGENTA}${message}${__DEVOXIO_COLORS_RESET}"
}

# ------------------------------------------------------------------------------
# Log a message @ fatal level.
#
# Arguments:
#   $* Message to display
# ------------------------------------------------------------------------------
function devoxio::log.fatal() {
    local message=$*
    devoxio::log.log \
        "${__DEVOXIO_LOG_LEVEL_FATAL}" \
        "${__DEVOXIO_COLORS_RED}${message}${__DEVOXIO_COLORS_RESET}"
}

# ------------------------------------------------------------------------------
# Changes the log level of Bashio on the fly.
#
# Arguments:
#   $1 Log level
# ------------------------------------------------------------------------------
function devoxio::log.level() {
    local log_level=${1}

    # Find the matching log level
    case "$(devoxio::string.lower "${log_level}")" in
    all)
        log_level="${__DEVOXIO_LOG_LEVEL_ALL}"
        ;;
    trace)
        log_level="${__DEVOXIO_LOG_LEVEL_TRACE}"
        ;;
    debug)
        log_level="${__DEVOXIO_LOG_LEVEL_DEBUG}"
        ;;
    info)
        log_level="${__DEVOXIO_LOG_LEVEL_INFO}"
        ;;
    notice)
        log_level="${__DEVOXIO_LOG_LEVEL_NOTICE}"
        ;;
    warning)
        log_level="${__DEVOXIO_LOG_LEVEL_WARNING}"
        ;;
    error)
        log_level="${__DEVOXIO_LOG_LEVEL_ERROR}"
        ;;
    fatal | critical)
        log_level="${__DEVOXIO_LOG_LEVEL_FATAL}"
        ;;
    off)
        log_level="${__DEVOXIO_LOG_LEVEL_OFF}"
        ;;
    *)
        devoxio::exit.nok "Unknown log_level: ${log_level}"
        ;;
    esac

    export __DEVOXIO_LOG_LEVEL="${log_level}"

    file="${__DEVOXIO_DEFAULT_ETC_DIR}/logging"
    if [ -f "${file}" ]; then
        sed -i "s/__DEVOXIO_LOG_LEVEL=.*/__DEVOXIO_LOG_LEVEL=${log_level}/" "${file}"
    fi

    return "${__DEVOXIO_EXIT_OK}"
}

# ------------------------------------------------------------------------------
# Inits the logging system
#
# ------------------------------------------------------------------------------
function devoxio::log.init() {

    if [ -f "${__DEVOXIO_DEFAULT_ETC_DIR}/logging" ]; then
        source "${__DEVOXIO_DEFAULT_ETC_DIR}/logging"
    fi
}