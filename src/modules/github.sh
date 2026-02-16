#!/usr/bin/env bash

declare __XBASHIO_GITHUB_OUTPUT_DIR="${__XBASHIO_VAR_DIR}"/output



# ------------------------------------------------------------------------------
# Writes a key-value pair to GitHub Actions output file.
# Arguments:
#   $1 Keyname of the output variable
#   $2 Value of the output variable
# ------------------------------------------------------------------------------
xbashio::github.write_output() {
    local key="${1:-}"
    local value="${2:-}"
    xbashio::log.trace "${FUNCNAME[0]}:"
    if xbashio::var.is_empty "${key}"; then
        xbashio::log.error "Keyname for output variable is empty"
        return "${__XBASHIO_EXIT_NOK}"
    fi
    if xbashio::var.is_empty "${value}"; then
        xbashio::log.error "Value for output variable '${key}' is empty"
        return "${__XBASHIO_EXIT_NOK}"
    fi
    if ! xbashio::fs.directory_exists "${__XBASHIO_GITHUB_OUTPUT_DIR}"; then
        mkdir -p "${__XBASHIO_GITHUB_OUTPUT_DIR}"
    fi
    local output_file="${GITHUB_OUTPUT:-${__XBASHIO_GITHUB_OUTPUT_DIR}/github_output}"
    xbashio::log.info "Writing output variable '${key}' with value
    '${value}' to GitHub Actions output file '${output_file}'"
    echo "${key}=${value}" >> "${output_file}"
    return "${__XBASHIO_EXIT_OK}"
}