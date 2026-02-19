[private]
test-with-bats:
    just info "Running tests for module {{ module_name }}..."
    bats "{{ test_dir }}"
    just success "Tests completed!"
