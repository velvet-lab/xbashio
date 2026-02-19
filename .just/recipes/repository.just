# Repository management recipes

import './common.just'

_releaserc_config := '''
{
  "branches": ["main"],
  "plugins": [
    "@semantic-release/commit-analyzer",
    "@semantic-release/release-notes-generator",
    "@semantic-release/changelog",
    "@semantic-release/npm",
    "@semantic-release/git"
  ]
}
'''

[private]
create-semantic-release-config:
    #!/usr/bin/env bash
    set -euo pipefail
    if [ ! -f ".releaserc.json" ]; then
        echo '{{_releaserc_config}}' > .releaserc.json
        just success "Created .releaserc.json for semantic-release!"
    else
        just warning ".releaserc.json already exists - skipping creation."
    fi

# Initialize repository structure
init:
    just info "Initializing repository structure..."
    if [ ! -f "package.json" ]; then npm init -y; fi
    bun add --dev semantic-release @semantic-release/git
    just create-semantic-release-config
    just success "Repository initialized!"
