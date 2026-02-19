#!/usr/bin/env bats

setup() {
    load "$BATS_TEST_DIRNAME"/../load
}

@test "convert a string to lower case" {
    result="$(xbashio::string.lower "HeLLo WoRLD")"
    assert_equal "$result" "hello world"
}

@test "convert a string to upper case" {
    result="$(xbashio::string.upper "HeLLo WoRLD")"
    assert_equal "$result" "HELLO WORLD"
}

@test "replace parts of a string" {
    result="$(xbashio::string.replace "Hello World" "World" "Bats")"
    assert_equal "$result" "Hello Bats"
}

@test "get the length of a string" {
    result="$(xbashio::string.length "Hello")"
    assert_equal "$result" "5"
}

@test "get the length of an empty string" {
    result="$(xbashio::string.length "")"
    assert_equal "$result" "0"
}

@test "replace with empty string" {
    result="$(xbashio::string.replace "Hello World" "World" "")"
    assert_equal "$result" "Hello "
}

@test "get part of a string from beginning" {
    result="$(xbashio::string.substring "Hello World" 0 5)"
    assert_equal "$result" "Hello"
}

@test "get part of a string from middle" {
    result="$(xbashio::string.substring "Hello World" 6 5)"
    assert_equal "$result" "World"
}
