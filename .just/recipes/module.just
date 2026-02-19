# Helps to create recipes for modules

# Repository-Vars
repo_root := clean(source_directory() / "../..")
repo_name := shell("basename $1", repo_root)

# Module-Vars
_module_name := shell("basename $1", justfile_directory())
module_root := if repo_name != _module_name { justfile_directory() } else { shell("pwd") }
module_name := shell("basename $1", module_root)

# Directories
src_dir := module_root / "src"
test_dir := module_root / "tests"
dist_dir := repo_root / "dist" / module_name

# Import utilities
import "./common.just"

# Install dependencies for all modules
[private]
install-node-modules:
  bun install

# Private recipe to detect changes in a file or directory
[private]
detect-changes path:
    #!/usr/bin/env bash
    set -euo pipefail

    if git diff --quiet HEAD~1 HEAD -- {{path}}; then
        echo "unchanged"
    else
        echo "changed"
    fi

[private]
run-release artifact_path tag_prefix:
    @just info "🚀 Release für {{artifact_path}} starten …"
    @npx semantic-release \
        --extends .releaserc.json \
        --plugin @semantic-release/git \
        --gitTagName "{{tag_prefix}}v${NEXT_VERSION}" \
        --pkgRoot {{artifact_path}}
