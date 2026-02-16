# xbashio - Justfile
# Command runner for development tasks
# See: https://just.systems/man/en/

# Load environment variables from .env file if it exists
set dotenv-load := true

# Import modular justfiles
import '.just/recipes/dev.just'
import '.just/recipes/test.just'
import '.just/recipes/build.just'
import '.just/recipes/ci.just'
import '.just/recipes/docs.just'
import '.just/recipes/clean.just'

# Use bash as the shell for all recipes
set shell := ["bash", "-uc"]

# Enable more verbose error messages
set positional-arguments := true

# List available recipes by default
default:
    @just --list

# Variables
project_name := "xbashio"
project_root := justfile_directory()

# Colors for output (using tput if available)
_color_reset := `tput sgr0 2>/dev/null || echo ""`
_color_bold := `tput bold 2>/dev/null || echo ""`
_color_green := `tput setaf 2 2>/dev/null || echo ""`
_color_yellow := `tput setaf 3 2>/dev/null || echo ""`
_color_blue := `tput setaf 4 2>/dev/null || echo ""`

# Private recipe to print colored messages
[private]
_print message color:
    @echo "{{color}}{{message}}{{_color_reset}}"
