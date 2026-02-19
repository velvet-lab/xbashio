#!/usr/bin/env bats

setup() {
    load "$BATS_TEST_DIRNAME"/../load
}

@test "exit.nok exits with failure code and message" {
    run xbashio::exit.nok "Test error message"
    assert_failure
    assert_output --partial "Test error message"
}

@test "exit.die_if_false exits when value is false" {
    run xbashio::exit.die_if_false false "Value was false"
    assert_failure
    assert_output --partial "Value was false"
}

@test "exit.die_if_false does not exit when value is true" {
    run xbashio::exit.die_if_false true "Value was true"
    assert_success
    assert_output --partial ""
}
