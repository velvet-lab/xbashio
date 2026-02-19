#!/usr/bin/env bats
# -*- coding: utf-8 -*-

load '../../../xbashio-core/load'
load 'bats-support/load'
load 'bats-assert/load'

# Load the plugin
source "${BATS_TEST_DIRNAME}/../src/--help.sh"

@test "--help: example test" {
    run xbashio::--help.example
    assert_success
}
