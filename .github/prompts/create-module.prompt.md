---
agent: 'workspace'
description: 'Create a new Bash module for xbashio'
tools: ['codebase']
---

# Create New xbashio Module

You are helping to create a new module for the xbashio Bash utility library.

## Steps to Create a Module

1. **Ask for module details:**
   - Module name (lowercase with hyphens)
   - Purpose and functionality
   - Whether it's a core utility or optional module
   - Dependencies required

2. **Create module file:**
   - Core utilities: `lib/xbashio/src/MODULE_NAME.sh`
   - Optional modules: `lib/xbashio/src/modules/MODULE_NAME.sh`

3. **Module structure:**
   ```bash
   #!/usr/bin/env bash
   #
   # Module: module_name
   # Version: 1.0.0
   # Description: Brief description
   # Dependencies: List any dependencies
   #

   set -euo pipefail

   # Source xbashio core if needed
   # source "$(dirname "${BASH_SOURCE[0]}")/xbashio.sh"

   # Constants (if any)
   readonly MODULE_CONSTANT="value"

   # Functions with proper headers
   ```

4. **Create Bats tests:**
   - File: `lib/xbashio/tests/MODULE_NAME.bats`
   - Test all public functions
   - Include success and failure cases

5. **Update documentation:**
   - Add module to main README.md
   - Create usage examples
   - Update load.bash if core module

6. **Create demo script (optional):**
   - File: `demos/MODULE_NAME.sh`
   - Show real-world usage

## Requirements

- Follow [bash.instructions.md](../.github/instructions/bash.instructions.md)
- Include complete function headers
- Add comprehensive tests
- Provide usage examples
- Use xbashio logging functions
- Validate all inputs
- Handle errors gracefully

## Example Module Structure

```bash
#!/usr/bin/env bash
#
# Module: example
# Version: 1.0.0
# Description: Example module template
#

set -euo pipefail

#######################################
# Function description
# Globals:
#   None
# Arguments:
#   $1 - First argument description
# Outputs:
#   Writes result to stdout
# Returns:
#   0 on success, 1 on error
#######################################
example_function() {
  local arg="${1:-}"
  
  # Validate input
  if [[ -z "${arg}" ]]; then
    echo "Error: argument is required" >&2
    return 1
  fi
  
  # Implementation
  echo "Result: ${arg}"
}
```

Begin by asking what kind of module should be created.
