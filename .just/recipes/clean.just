
[private]
clean-dist:
  just info "Cleaning build artifacts for module {{module_name}}..."
  rm -rf {{dist_dir}}/*
  just success "Clean completed!"
