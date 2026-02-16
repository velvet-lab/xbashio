#!/usr/bin/env bats

setup() {
    load "$BATS_TEST_DIRNAME"/../node_modules/bats-support/load
    load "$BATS_TEST_DIRNAME"/../node_modules/bats-assert/load
    load "$BATS_TEST_DIRNAME"/../src/load
}

@test "test default logging" {
    run devoxio::log "Default logging output"
    assert_success
    assert_output "Default logging output"
}

@test "test trace logging with no output, because default level is info" {
    run devoxio::log.trace "Trace logging output"
    assert_success
    assert_output --partial ""
}

@test "test trace logging with level trace" {
    devoxio::log.level trace
    run devoxio::log.trace "Trace logging output"
    assert_success
    assert_output --partial "Trace logging output"
}

@test "test debug logging with no output, because default level is info" {
    run devoxio::log.debug "Debug logging output"
    assert_success
    assert_output --partial ""
}

@test "test trace logging with level debug" {
    devoxio::log.level debug
    run devoxio::log.debug "Debug logging output"
    assert_success
    assert_output --partial "Debug logging output"
}

@test "test info logging" {
    run devoxio::log.info "Info logging output"
    assert_success
    assert_output --partial "Info logging output"
}

@test "test notice logging" {
    run devoxio::log.notice "Notice logging output"
    assert_success
    assert_output --partial "Notice logging output"
}

@test "test warning logging" {
    run devoxio::log.warning "Warning logging output"
    assert_success
    assert_output --partial "Warning logging output"
}

@test "test error logging" {
    run devoxio::log.error "Error logging output"
    assert_success
    assert_output --partial "Error logging output"
}

@test "test fatal logging" {
    run devoxio::log.fatal "Fatal logging output"
    assert_success
    assert_output --partial "Fatal logging output"
}

