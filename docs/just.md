# Just Task Runner Documentation

This document describes the Just task runner setup for the xbashio project.

## Overview

The project uses [Just](https://github.com/casey/just) as a command runner for development tasks. Just is like Make but designed specifically for commands rather than building files.

## Quick Start

```bash
# List all available commands
just --list

# Run a specific command
just <recipe-name>
```

## Project Structure

```
justfile              # Main justfile (entry point)
.just/
├── recipes/          # Modular justfile recipes (imported by main justfile)
│   ├── dev.just     # Development tasks (setup, formatting, linting)
│   ├── test.just    # Testing tasks (unit tests, integration, coverage)
│   ├── build.just   # Build and packaging tasks
│   ├── ci.just      # CI/CD and validation tasks
│   ├── docs.just    # Documentation generation and serving
│   └── clean.just   # Cleanup tasks
└── lib/             # Shell scripts and helper functions (sourced by recipes)
```

## Recipe Organization

Recipes are organized by domain to keep the justfile modular and maintainable:

- **dev.just**: Development workflow tasks
- **test.just**: All testing-related commands
- **build.just**: Build, package, and installation tasks
- **ci.just**: Continuous integration and pre-commit hooks
- **docs.just**: Documentation generation and serving
- **clean.just**: Cleanup and maintenance tasks

## Best Practices

### Recipe Design

1. **Modularity**: Keep related recipes together in their respective files
2. **Naming**: Use clear, descriptive recipe names (lowercase, hyphen-separated)
3. **Documentation**: Add comments above each recipe explaining what it does
4. **Parameters**: Use typed parameters where appropriate
5. **Private Recipes**: Mark internal helpers with `[private]` attribute
6. **Dependencies**: Use recipe dependencies for task orchestration

### Shell Scripts in lib/

The `.just/lib/` directory contains reusable shell functions:

- Use clear, descriptive function names
- Add comments documenting function parameters and return values
- Follow the xbashio project's bash coding standards
- Keep functions focused and single-purpose
- Use proper error handling with `set -euo pipefail`

### Usage Example

```just
# In .just/recipes/dev.just

# Source a library script
[private]
_helper:
    #!/usr/bin/env bash
    source {{justfile_directory()}}/.just/lib/helpers.sh
    some_helper_function

# Public recipe using the helper
format: _helper
    @echo "Formatting code..."
```

## Adding New Recipes

1. Identify the appropriate recipe file based on the task domain
2. Add the recipe with proper documentation
3. Mark private helpers with `[private]` attribute
4. Use recipe dependencies instead of calling recipes within scripts
5. Test the recipe with `just <recipe-name>`

## Configuration

The main justfile includes project-wide settings:

- **dotenv-load**: Automatically loads `.env` file if present
- **shell**: Uses bash for all recipes
- **positional-arguments**: Enables better argument handling

## References

- [Just Manual](https://just.systems/man/en/)
- [Just GitHub Repository](https://github.com/casey/just)
- [Just Examples](https://github.com/casey/just/tree/master/examples)
