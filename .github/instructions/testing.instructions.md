---
applyTo: "**/*.bats"
description: "Bats testing best practices for xbashio"
---

# Testing Guidelines with Bats

## Testing Philosophy

- Write tests before or alongside code (TDD approach)
- Test both success and failure cases
- Keep tests isolated and independent
- Use descriptive test names that explain behavior
- Mock external dependencies when possible

## Bats Test Structure

```bash
#!/usr/bin/env bats

# Load test helpers
load '../node_modules/bats-support/load'
load '../node_modules/bats-assert/load'

# Load the module being tested
load '../src/module_name'

setup() {
  # Runs before each test
  export TEST_VAR="value"
  TEST_DIR="$(mktemp -d)"
}

teardown() {
  # Runs after each test
  [[ -d "${TEST_DIR}" ]] && rm -rf "${TEST_DIR}"
}

@test "function_name: should succeed when input is valid" {
  run function_name "valid_input"
  assert_success
  assert_output "expected output"
}

@test "function_name: should fail when input is invalid" {
  run function_name ""
  assert_failure
  assert_output --partial "Error:"
}
```

## Test Naming Convention

Use this format: `"module.function: should [behavior] when [condition]"`

Examples:
- `"string.trim: should remove leading spaces when string starts with spaces"`
- `"log.error: should write to stderr when called with message"`
- `"var.is_empty: should return 0 when variable is undefined"`

## Assertion Best Practices

### Use bats-assert Helpers
- `assert_success` - Check command succeeded (exit 0)
- `assert_failure` - Check command failed (non-zero exit)
- `assert_output "expected"` - Exact output match
- `assert_output --partial "text"` - Partial match
- `assert_line "expected"` - Check specific line
- `refute_output "unexpected"` - Assert output doesn't contain text

### Test Multiple Scenarios
```bash
@test "function handles various inputs correctly" {
  # Test normal case
  run function_name "normal"
  assert_success
  
  # Test edge case
  run function_name ""
  assert_failure
  
  # Test another edge case
  run function_name "$(printf '%1000s')"
  assert_success
}
```

## Testing xbashio Functions

### Testing Logging Functions
```bash
@test "log_info: should output to stdout with INFO prefix" {
  run log_info "test message"
  assert_success
  assert_output --partial "INFO"
  assert_output --partial "test message"
}
```

### Testing Variable Functions
```bash
@test "var_is_empty: should return 0 for undefined variable" {
  unset UNDEFINED_VAR
  run var_is_empty "UNDEFINED_VAR"
  assert_success
}
```

### Testing String Functions
```bash
@test "string_trim: should remove leading and trailing whitespace" {
  run string_trim "  test  "
  assert_success
  assert_output "test"
}
```

## Testing Module Functions

When testing functions that interact with system:
- Mock system calls when possible
- Use temporary directories for file operations
- Clean up resources in teardown
- Don't rely on specific system state

```bash
@test "module.install: should create config file in temp directory" {
  local config_dir="${TEST_DIR}/config"
  run module_install "${config_dir}"
  assert_success
  [[ -f "${config_dir}/module.conf" ]]
}
```

## Coverage Goals

- Aim for 80%+ code coverage
- Every public function should have tests
- Critical paths must have comprehensive tests
- Error handling paths must be tested

## Running Tests

```bash
# Run all tests
bats tests/

# Run specific test file
bats tests/string.bats

# Run with verbose output
bats -t tests/

# Run with timing information
bats --timing tests/
```

## Common Patterns

### Testing Function with Options
```bash
@test "function: handles -v flag correctly" {
  run function -v "input"
  assert_success
  assert_output --partial "verbose output"
}
```

### Testing Error Messages
```bash
@test "function: provides helpful error on missing arg" {
  run function
  assert_failure
  assert_output --partial "Error: argument required"
}
```

### Testing Output Format
```bash
@test "function: outputs valid JSON" {
  run function "test"
  assert_success
  # Validate JSON using jq
  echo "${output}" | jq -e . > /dev/null
}
```
