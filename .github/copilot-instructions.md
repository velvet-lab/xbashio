# xbashio Project - GitHub Copilot Instructions

This document provides project-wide coding standards and guidelines for the xbashio library - a Bash test helper library for testing shell scripts with Bats.

## Project Overview

xbashio is a comprehensive Bash utility library that provides:
- Core shell scripting utilities (logging, colors, variables, strings)
- Module system for package management (apt, npm, jq, ssh, security)
- Bats test framework integration
- Demo scripts showcasing library capabilities

## Core Principles

1. **Simplicity**: Write clear, readable shell scripts that follow POSIX standards where possible
2. **Safety**: Always use safe scripting practices (set -euo pipefail, proper quoting, etc.)
3. **Modularity**: Keep functions small, focused, and reusable
4. **Testing**: All new functionality must include Bats tests
5. **Documentation**: Provide clear inline comments and usage examples

## Technology Stack

- **Language**: Bash/Shell scripting
- **Testing**: Bats (Bash Automated Testing System)
- **Package Manager**: bun (for development tooling)
- **Dependencies**: bats-assert, bats-support

## Development Guidelines

### Script Structure
- Use `#!/usr/bin/env bash` as shebang
- Enable strict mode: `set -euo pipefail`
- Source the xbashio library: `source "$(dirname "${BASH_SOURCE[0]}")/../lib/xbashio/load.bash"`
- Follow the existing module structure in `lib/xbashio/src/`

### Naming Conventions
- Functions: lowercase with underscores (e.g., `log_info`, `string_trim`)
- Constants: UPPERCASE with underscores (e.g., `EXIT_SUCCESS`, `COLOR_RED`)
- Private functions: prefix with underscore (e.g., `_internal_helper`)
- Files: lowercase with hyphens for multi-word names

### Code Style
- Use 2-space indentation
- Maximum line length: 100 characters
- Always quote variables: `"${var}"` not `$var`
- Use `[[` for conditionals instead of `[`
- Prefer `local` for function variables

### Error Handling
- Always validate input parameters
- Provide meaningful error messages
- Use appropriate exit codes (see `src/exit.sh` for constants)
- Clean up temporary resources with `trap`

### Testing Standards
- Write Bats tests for all new functions
- Test files live in `tests/` directory with `.bats` extension
- Use descriptive test names: `@test "function_name: should do something when condition"`
- Use bats-assert helpers for assertions
- Test both success and failure cases

### Documentation
- Add function headers with description, parameters, and examples
- Update README.md when adding new modules
- Include usage examples in demo scripts
- Document any external dependencies

## File Organization

```
lib/xbashio/
├── load.bash              # Main entry point
├── src/
│   ├── xbashio.sh        # Core library loader
│   ├── *.sh              # Core utilities (log, color, string, etc.)
│   └── modules/          # Optional modules (apt, node, ssh, etc.)
└── tests/                # Bats test files
```

## Related Instructions

Refer to specific instruction files for detailed guidelines:
- [Bash Development](./instructions/bash.instructions.md)
- [Testing with Bats](./instructions/testing.instructions.md)
- [Security Best Practices](./instructions/security.instructions.md)
- [Code Review Standards](./instructions/code-review.instructions.md)
