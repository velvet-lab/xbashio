#!/usr/bin/env bats

setup() {
    load "$BATS_TEST_DIRNAME"/../node_modules/@velvet-lab/xbashio
}

@test "Automation Script" {
    run "$BATS_TEST_DIRNAME/../src/automation-script.sh"
}
