---
agent: 'workspace'
description: 'Generate or update documentation for xbashio modules and functions'
tools: ['codebase']
---

# Generate Documentation

You are helping to create or update documentation for the xbashio project.

## Documentation Types

What needs to be documented?
1. **Function Headers** - Inline documentation for functions
2. **Module README** - Usage guide for a module
3. **API Documentation** - Reference for public APIs
4. **Tutorial/Guide** - How-to documentation
5. **Demo Script** - Executable example

## Function Header Template

```bash
#######################################
# Brief one-line description of what this function does
# Longer description if needed that explains the purpose,
# behavior, and any important implementation details
# Globals:
#   GLOBAL_VAR - Description of global variable used/modified
#   ANOTHER_VAR - Another global variable
# Arguments:
#   $1 - Description of first argument (type, purpose)
#   $2 - Description of second argument (optional)
# Outputs:
#   Writes result to stdout
#   Writes errors to stderr
# Returns:
#   0 on success
#   1 on invalid input
#   2 on processing error
# Examples:
#   function_name "example" "arguments"
#   function_name --flag "value"
#######################################
function_name() {
  # Implementation
}
```

## Module README Template

```markdown
# Module Name

Brief description of what this module provides.

## Installation

```bash
# How to load this module
source /path/to/module.sh
```

## Usage

### function_name

Description of the function and its purpose.

**Parameters:**
- `$1` (string, required) - Description
- `$2` (string, optional) - Description

**Returns:**
- `0` - Success
- `1` - Error condition

**Example:**
```bash
function_name "arg1" "arg2"
if (( $? == 0 )); then
  echo "Success"
fi
```

### another_function

[Similar format for each function]

## Dependencies

- bash 4.0+
- External commands: jq, curl
- xbashio modules: log, string

## Environment Variables

- `MODULE_CONFIG` - Configuration file path (default: ~/.config/module.conf)
- `MODULE_DEBUG` - Enable debug output (default: false)

## Examples

### Basic Usage
```bash
#!/usr/bin/env bash
source xbashio
source module_name.sh

module_function "argument"
```

### Advanced Usage
```bash
# More complex example
```

## Troubleshooting

Common issues and solutions.

## See Also

- [Related Module](../related/README.md)
- [xbashio Documentation](../../README.md)
```

## Demo Script Template

```bash
#!/usr/bin/env bash
#
# Demo: Module Name
# Description: This script demonstrates how to use the module_name module
#

set -euo pipefail

# Load xbashio library
source "$(dirname "${BASH_SOURCE[0]}")/../lib/xbashio/load.bash"

log_info "Starting module demo"
log_info "===================="

# Example 1: Basic usage
log_info "Example 1: Basic usage"
if module_function "example_arg"; then
  log_success "Basic usage successful"
else
  log_error "Basic usage failed"
  exit 1
fi

# Example 2: Advanced usage
log_info ""
log_info "Example 2: Advanced usage"
result="$(module_function --advanced "arg")"
log_info "Result: ${result}"

# Example 3: Error handling
log_info ""
log_info "Example 3: Error handling"
if module_function ""; then
  log_warning "Expected error didn't occur"
else
  log_success "Error handling works correctly"
fi

log_info ""
log_success "Demo completed successfully"
```

## Documentation Guidelines

### Writing Style
- Use clear, concise language
- Write in present tense
- Use active voice
- Provide concrete examples
- Explain the "why" not just the "what"

### Code Examples
- Complete and runnable
- Show realistic use cases
- Include error handling
- Add comments explaining key steps
- Test examples to ensure they work

### Structure
- Start with overview and purpose
- Explain prerequisites/dependencies
- Show basic usage first
- Progress to advanced usage
- Include troubleshooting section

### Keep Updated
- Update docs when code changes
- Mark deprecated features
- Provide migration guides
- Version significant changes

## Documentation Checklist

- [ ] Function headers are complete
- [ ] README includes all public functions
- [ ] Examples are tested and work
- [ ] Dependencies are documented
- [ ] Return values are explained
- [ ] Error conditions are described
- [ ] Cross-references to related docs
- [ ] Spelling and grammar checked

## Guidelines

- Follow [documentation.instructions.md](../.github/instructions/documentation.instructions.md)
- Ensure accuracy and completeness
- Use consistent formatting
- Provide helpful examples
- Keep it up-to-date

Begin by asking what needs to be documented.
