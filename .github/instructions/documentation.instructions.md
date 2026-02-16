---
applyTo: "**/*.md,**/*.sh,**/*.bash"
description: "Documentation standards for xbashio"
---

# Documentation Standards

## Markdown Documentation

### README Files
- Start with clear project description
- Include installation instructions
- Provide usage examples with actual code
- Document all public APIs
- Keep examples up-to-date with code
- Use code blocks with syntax highlighting

### Structure for Module READMEs
```markdown
# Module Name

Brief description of what the module does.

## Installation

How to source/load the module.

## Usage

### function_name

Description of the function.

**Parameters:**
- `$1` - Description
- `$2` - Description

**Returns:**
- `0` on success
- `1` on error

**Example:**
\```bash
function_name "arg1" "arg2"
\```

## Dependencies

List any external dependencies.
```

## Inline Code Documentation

### Function Headers
Every public function must have a header comment:

```bash
#######################################
# Brief one-line description
# Longer description if needed explaining
# what the function does in detail
# Globals:
#   GLOBAL_VAR - Description of global used/modified
# Arguments:
#   $1 - Description of first argument
#   $2 - Description of second argument (optional)
# Outputs:
#   Writes result to stdout
#   Writes errors to stderr
# Returns:
#   0 on success, non-zero on error
# Examples:
#   function_name "example" "args"
#######################################
function_name() {
  # Implementation
}
```

### Module Headers
Every module file should start with:

```bash
#!/usr/bin/env bash
#
# Module: module_name
# Version: 1.0.0
# Description: What this module provides
# Dependencies: List of required modules or commands
#
# Example:
#   source module_name.sh
#   module_function "args"
#

set -euo pipefail
```

## Code Comments

### When to Comment
- Complex algorithms or logic
- Non-obvious workarounds
- Security considerations
- Performance optimizations
- Reasons for specific implementation choices

### When NOT to Comment
- Obvious code that explains itself
- Redundant descriptions of what code does
- Outdated comments that don't match code

### Comment Style
```bash
# Single line comments for brief explanations

# Multi-line comments for detailed explanations
# should be wrapped at 80 characters and each
# line should start with hash and space

# FIXME: Known issues that need fixing
# TODO: Planned improvements
# NOTE: Important information
# HACK: Temporary workarounds
```

## Usage Examples in Demos

Demo scripts in `demos/` should:
- Show realistic use cases
- Include comments explaining each step
- Handle errors gracefully
- Print informative output
- Be runnable as-is

```bash
#!/usr/bin/env bash

# Demo: SSH Key Creation
# This script demonstrates how to use xbashio's SSH module

set -euo pipefail

# Load xbashio library
source "$(dirname "${BASH_SOURCE[0]}")/../lib/xbashio/load.bash"

log_info "Starting SSH key creation demo"

# Create SSH key with specified parameters
if ssh_create_key "${HOME}/.ssh/demo_key" "demo@example.com"; then
  log_success "SSH key created successfully"
else
  log_error "Failed to create SSH key"
  exit 1
fi
```

## API Documentation

### When Adding New Functions
1. Add function to appropriate module file
2. Include complete function header
3. Add tests in corresponding `.bats` file
4. Update module README with usage example
5. Add to main README if it's a core function
6. Update CHANGELOG if applicable

### Documenting Breaking Changes
- Mark deprecated functions with `@deprecated` tag
- Provide migration path in comment
- Update major version number
- Document in CHANGELOG with clear upgrade path

## Documentation Review

Before committing:
- [ ] All public functions have headers
- [ ] README examples are tested
- [ ] No TODO comments without issue numbers
- [ ] Breaking changes are documented
- [ ] New modules have README files
- [ ] Demo scripts are up-to-date
