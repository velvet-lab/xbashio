#!/usr/bin/env bash

declare __DEVOXIO_GITHUB_OUTPUT_DIR="${__DEVOXIO_VAR_DIR}"/output



# ------------------------------------------------------------------------------
# Writes a key-value pair to GitHub Actions output file.
# Arguments:
#   $1 Keyname of the output variable
#   $2 Value of the output variable
# ------------------------------------------------------------------------------
devoxio::github.write_output() {
    local key="${1:-}"
    local value="${2:-}"
    devoxio::log.trace "${FUNCNAME[0]}:"
    if devoxio::var.is_empty "${key}"; then
        devoxio::log.error "Keyname for output variable is empty"
        return "${__DEVOXIO_EXIT_NOK}"
    fi
    if devoxio::var.is_empty "${value}"; then
        devoxio::log.error "Value for output variable '${key}' is empty"
        return "${__DEVOXIO_EXIT_NOK}"
    fi
    if ! devoxio::fs.directory_exists "${__DEVOXIO_GITHUB_OUTPUT_DIR}"; then
        mkdir -p "${__DEVOXIO_GITHUB_OUTPUT_DIR}"
    fi
    local output_file="${GITHUB_OUTPUT:-${__DEVOXIO_GITHUB_OUTPUT_DIR}/github_output}"
    devoxio::log.info "Writing output variable '${key}' with value
    '${value}' to GitHub Actions output file '${output_file}'"
    echo "${key}=${value}" >> "${output_file}"
    return "${__DEVOXIO_EXIT_OK}"
}