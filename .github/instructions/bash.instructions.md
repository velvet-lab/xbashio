<!-- Based on: https://github.com/github/awesome-copilot/blob/main/instructions/shell.instructions.md -->
---
applyTo: "**/*.sh,**/*.bash,**/xbashio"
description: "Bash development best practices for the xbashio library"
---

# Bash Development Guidelines

## General Principles

- Generate code that is clean, simple, and concise
- Ensure scripts are easily readable and understandable
- Add comments where helpful for understanding how the script works
- Generate concise and simple echo outputs to provide execution status
- Use shellcheck for static analysis when available
- Prefer safe expansions: double-quote variable references (`"$var"`), use `${var}` for clarity, and avoid `eval`
- Use modern Bash features (`[[ ]]`, `local`, arrays) when appropriate
- Choose reliable parsers for structured data instead of ad-hoc text processing

## Error Handling & Safety

- Always enable `set -euo pipefail` at the start of scripts
- Validate all required parameters before execution
- Provide clear error messages with context
- Use `trap` to clean up temporary resources
- Declare immutable values with `readonly` or `declare -r`
- Use `mktemp` to create temporary files safely

## Script Structure for xbashio

```bash
#!/usr/bin/env bash
#
# Module: module_name
# Description: Brief description of what this module does
#

set -euo pipefail

# Source xbashio core if needed
# source "$(dirname "${BASH_SOURCE[0]}")/xbashio.sh"

# Constants
readonly MODULE_VERSION="1.0.0"

# Functions

#######################################
# Function description
# Globals:
#   VAR_NAME
# Arguments:
#   $1 - First argument description
#   $2 - Second argument description
# Outputs:
#   Writes result to stdout
# Returns:
#   0 on success, non-zero on error
#######################################
function_name() {
  local arg1="${1:-}"
  local arg2="${2:-}"
  
  # Validate inputs
  if [[ -z "${arg1}" ]]; then
    echo "Error: argument 1 is required" >&2
    return 1
  fi
  
  # Function logic here
  echo "Result"
}
```

## xbashio Specific Guidelines

### Module Development
- Place core utilities in `lib/xbashio/src/`
- Place optional modules in `lib/xbashio/src/modules/`
- Export functions that should be public
- Prefix internal helpers with underscore

### Logging
- Use xbashio logging functions: `log_info`, `log_success`, `log_warning`, `log_error`, `log_debug`
- Never use plain `echo` for status messages in library functions
- Use appropriate log levels for different message types

### Variable Management
- Use xbashio variable functions: `var_has`, `var_is_empty`, `var_is_number`
- Always validate user input before processing
- Use descriptive variable names

### String Operations
- Use xbashio string functions: `string_trim`, `string_to_upper`, `string_to_lower`
- Don't reinvent string manipulation when xbashio provides it

## Working with JSON and YAML

- Prefer `jq` for JSON manipulation (use xbashio's jq module)
- Validate that required fields exist
- Handle missing/invalid data explicitly
- Quote jq filters to prevent shell expansion
- Prefer `--raw-output` for plain strings

## Code Quality Checks

Before committing:
- Run `shellcheck` on all modified scripts
- Ensure all tests pass: `bats tests/`
- Verify no unquoted variables
- Check for proper error handling
- Confirm cleanup code executes properly
