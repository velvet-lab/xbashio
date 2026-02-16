#!/usr/bin/env bats

setup() {
    load "$BATS_TEST_DIRNAME"/../node_modules/bats-support/load
    load "$BATS_TEST_DIRNAME"/../node_modules/bats-assert/load
    load "$BATS_TEST_DIRNAME"/../src/load
}

@test "test that bool variable ist true" {
    test_var=true

    run devoxio::var.true $test_var
    assert_success
}

@test "test that bool variable ist false" {
    test_var=false

    run devoxio::var.false $test_var
    assert_success
}

@test "test that string variable ist true" {
    test_var="true"

    run devoxio::var.true $test_var
    assert_success
}

@test "test that string variable ist false" {
    test_var="false"

    run devoxio::var.false $test_var
    assert_success
}

@test "test that integer variable ist true" {
    test_var=1

    run devoxio::var.true $test_var
    assert_success
}

@test "test that integer variable ist false" {
    test_var=0

    run devoxio::var.false $test_var
    assert_success
}

@test "test that undefined variable is not defined" {
    run devoxio::var.defined "undefined_var"
    assert_failure
}

@test "test that defined variable is defined" {
    defined_var="I am defined"

    run devoxio::var.defined "defined_var"
    assert_success
}

@test "test that variable has value" {
    test_var="I have a value"

    run devoxio::var.has_value "$test_var"
    assert_success
}

@test "test that variable has no value" {
    test_var=""

    run devoxio::var.has_value "$test_var"
    assert_failure
}

@test "test that variable is empty" {
    test_var=""

    run devoxio::var.is_empty "$test_var"
    assert_success
}

@test "test that variable is not empty" {
    test_var="I am not empty"

    run devoxio::var.is_empty "$test_var"
    assert_failure
}

@test "test that variable equals another variable" {
    var1="same value"
    var2="same value"

    run devoxio::var.equals "$var1" "$var2"
    assert_success
}

@test "test that variable does not equal another variable" {
    var1="value one"
    var2="value two"

    run devoxio::var.equals "$var1" "$var2"
    assert_failure
}
