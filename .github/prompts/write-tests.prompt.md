---
agent: 'workspace'
description: 'Generate comprehensive Bats tests for xbashio functions'
tools: ['codebase']
---

# Write Bats Tests

You are helping to write comprehensive Bats tests for xbashio functions.

## Test Requirements

1. **Ask for context:**
   - Which function(s) to test?
   - Location of source file
   - Any special test requirements?

2. **Generate test structure:**
   ```bash
   #!/usr/bin/env bats

   # Load test helpers
   load '../node_modules/bats-support/load'
   load '../node_modules/bats-assert/load'

   # Load the module being tested
   load '../src/MODULE_NAME'

   setup() {
     # Test setup
     export TEST_VAR="value"
     TEST_DIR="$(mktemp -d)"
   }

   teardown() {
     # Test cleanup
     [[ -d "${TEST_DIR}" ]] && rm -rf "${TEST_DIR}"
   }
   ```

3. **Test coverage areas:**
   - Normal operation (happy path)
   - Edge cases (empty input, max values, etc.)
   - Error conditions (invalid input, missing files)
   - Boundary conditions
   - Integration with other xbashio functions

4. **Test naming:**
   Format: `"module.function: should [behavior] when [condition]"`
   
   Examples:
   - `"log.info: should output to stdout when called with message"`
   - `"string.trim: should remove whitespace when string has leading spaces"`
   - `"var.is_empty: should return 0 when variable is undefined"`

5. **Assertions to use:**
   - `assert_success` - Command succeeded
   - `assert_failure` - Command failed
   - `assert_output "text"` - Exact output match
   - `assert_output --partial "text"` - Contains text
   - `assert_line -n 0 "text"` - Specific line match
   - `refute_output "text"` - Output doesn't contain

## Test Template

```bash
@test "function_name: should succeed with valid input" {
  run function_name "valid_arg"
  assert_success
  assert_output "expected output"
}

@test "function_name: should fail with empty input" {
  run function_name ""
  assert_failure
  assert_output --partial "Error:"
}

@test "function_name: should handle special characters" {
  run function_name "special!@#$"
  assert_success
}

@test "function_name: should write to stderr on error" {
  run function_name "invalid"
  assert_failure
  assert_output --partial "Error:"
}
```

## Testing Best Practices

- Test one thing per test case
- Use descriptive test names
- Test both stdout and stderr when relevant
- Clean up resources in teardown
- Use setup for common initialization
- Mock external commands when needed
- Test return codes explicitly

## Guidelines

- Follow [testing.instructions.md](../.github/instructions/testing.instructions.md)
- Aim for 80%+ code coverage
- Test all public functions
- Include integration tests for workflows
- Ensure tests are isolated and can run in any order

Begin by asking which functions need tests.
