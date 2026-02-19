# xbashio-core Module

set shell := ["bash", "-uc"]
set quiet := true

# Module-Vars
import "../.just/recipes/module.just"
import "../.just/recipes/build.just"
import "../.just/recipes/clean.just"
import "../.just/recipes/test.just"

# List available recipes (default)
default: default-recipe

# Installs dependencies for module
install: install-node-modules

# Clean build artifacts
clean: clean-dist

# Build recipe for xbashio-core
build: build-with-bun

# Test recipe for xbashio-core
test: test-with-bats

release:
    #!/usr/bin/env bash
    set -euo pipefail
    # Prüfe auf Änderungen
    status=$(just detect-changes {{module_root}})

    if [[ "${status}" == "unchanged" ]]; then
        just success "🔍 Keine Änderungen in '{{module_name}}' - Release überspringen."
        exit 0
    fi

    just warning "🚀 Änderungen erkannt in '{{module_name}}'' - Release wird durchgeführt."
