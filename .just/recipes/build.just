
[private]
build-with-bun:
  just info "Building the project {{module_name}}..."
  bun pm pack --destination {{dist_dir}}
  just success "Build completed!"
