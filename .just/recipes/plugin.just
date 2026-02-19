# Plugin management recipes

# Import utilities
import './common.just'

# Repository-Vars
repo_root := clean(source_directory() / "../..")
plugins_dir := repo_root / "xbashio-plugins"

# Create a new plugin with required structure
create-plugin name:
    #!/usr/bin/env bash
    set -euo pipefail

    PLUGIN_NAME="{{name}}"
    PLUGIN_DIR="{{plugins_dir}}/${PLUGIN_NAME}"

    # Check if plugin already exists
    if [ -d "${PLUGIN_DIR}" ]; then
        just fatal "Plugin '${PLUGIN_NAME}' already exists at ${PLUGIN_DIR}"
    fi

    just info "Creating new plugin: ${PLUGIN_NAME}"

    # Create directory structure
    mkdir -p "${PLUGIN_DIR}/src"
    mkdir -p "${PLUGIN_DIR}/tests"

    # Create package.json
    cat > "${PLUGIN_DIR}/package.json" <<EOF
    {
      "name": "${PLUGIN_NAME}",
      "version": "1.0.0"
    }
    EOF

    # Create main plugin script
    cat > "${PLUGIN_DIR}/src/${PLUGIN_NAME}.sh" <<'EOFSCRIPT'
    #!/usr/bin/env bash
    # -*- coding: utf-8 -*-

    # ------------------------------------------------------------------------------
    # Example function for {{name}} plugin
    #
    # Description:
    #   Add your function description here
    #
    # Returns:
    #   0 on success, non-zero on error
    # ------------------------------------------------------------------------------
    xbashio::{{name}}.example() {

        xbashio::log.trace "${FUNCNAME[0]}:"

        xbashio::log.info "Example function for {{name}}"

        # Add your implementation here

        return "${__XBASHIO_EXIT_OK}"
    }
    EOFSCRIPT

    # Create test file
    cat > "${PLUGIN_DIR}/tests/${PLUGIN_NAME}.bats" <<'EOFTEST'
    #!/usr/bin/env bats
    # -*- coding: utf-8 -*-

    load '../../../xbashio-core/load'
    load 'bats-support/load'
    load 'bats-assert/load'

    # Load the plugin
    source "${BATS_TEST_DIRNAME}/../src/{{name}}.sh"

    @test "{{name}}: example test" {
        run xbashio::{{name}}.example
        assert_success
    }
    EOFTEST

    # Make scripts executable
    chmod +x "${PLUGIN_DIR}/src/${PLUGIN_NAME}.sh"
    chmod +x "${PLUGIN_DIR}/tests/${PLUGIN_NAME}.bats"

    just success "Plugin '${PLUGIN_NAME}' created successfully!"
    just info "Plugin location: ${PLUGIN_DIR}"
    just info "Next steps:"
    echo "  1. Edit ${PLUGIN_DIR}/src/${PLUGIN_NAME}.sh to implement your plugin"
    echo "  2. Edit ${PLUGIN_DIR}/tests/${PLUGIN_NAME}.bats to add tests"
    echo "  3. Run 'bats ${PLUGIN_DIR}/tests/${PLUGIN_NAME}.bats' to test"

# List all plugins
list-plugins:
    #!/usr/bin/env bash
    set -euo pipefail

    just info "Available plugins:"
    for plugin_dir in {{plugins_dir}}/*; do
        if [ -d "$plugin_dir" ]; then
            plugin_name=$(basename "$plugin_dir")
            if [ -f "$plugin_dir/package.json" ]; then
                version=$(grep -o '"version"[[:space:]]*:[[:space:]]*"[^"]*"' "$plugin_dir/package.json" | cut -d'"' -f4 || echo "unknown")
                echo "  • $plugin_name (v$version)"
            else
                echo "  • $plugin_name"
            fi
        fi
    done
