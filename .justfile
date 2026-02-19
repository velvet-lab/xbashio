# xbashio - Justfile
# Command runner for development tasks
# See: https://just.systems/man/en/

set dotenv-load := true
set shell := ["bash", "-uc"]
set positional-arguments := true
set quiet := true

# Module imports
mod xbashio-core 'xbashio-core/.justfile'

# Import utilities
import '.just/recipes/repository.just'
import '.just/recipes/plugin.just'

# List available recipes (default)
default: default-recipe

# Install dependencies for all modules
install:
    just xbashio-core::install

# Clean all artefacts
clean:
    just xbashio-core::clean

# Build all modules
build:
    just xbashio-core::build

# Tests all modules
test:
    just xbashio-core::test

# Interaktives Changeset mit Bun
change:
    bunx changeset

# Versionen bumpen
bump:
    bunx changeset version
