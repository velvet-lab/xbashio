#!/usr/bin/env bats

setup() {
    load "$BATS_TEST_DIRNAME"/../node_modules/bats-support/load
    load "$BATS_TEST_DIRNAME"/../node_modules/bats-assert/load
    load "$BATS_TEST_DIRNAME"/../load
}

@test "test default logging" {
    run xbashio::log "Default logging output"
    assert_success
    assert_output "Default logging output"
}

@test "test trace logging with no output, because default level is info" {
    run xbashio::log.trace "Trace logging output"
    assert_success
    assert_output --partial ""
}

@test "test trace logging with level trace" {
    xbashio::log.level trace
    run xbashio::log.trace "Trace logging output"
    assert_success
    assert_output --partial "Trace logging output"
}

@test "test debug logging with no output, because default level is info" {
    run xbashio::log.debug "Debug logging output"
    assert_success
    assert_output --partial ""
}

@test "test trace logging with level debug" {
    xbashio::log.level debug
    run xbashio::log.debug "Debug logging output"
    assert_success
    assert_output --partial "Debug logging output"
}

@test "test info logging" {
    run xbashio::log.info "Info logging output"
    assert_success
    assert_output --partial "Info logging output"
}

@test "test notice logging" {
    run xbashio::log.notice "Notice logging output"
    assert_success
    assert_output --partial "Notice logging output"
}

@test "test warning logging" {
    run xbashio::log.warning "Warning logging output"
    assert_success
    assert_output --partial "Warning logging output"
}

@test "test error logging" {
    run xbashio::log.error "Error logging output"
    assert_success
    assert_output --partial "Error logging output"
}

@test "test fatal logging" {
    run xbashio::log.fatal "Fatal logging output"
    assert_success
    assert_output --partial "Fatal logging output"
}
