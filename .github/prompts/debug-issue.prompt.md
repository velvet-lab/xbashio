---
agent: 'workspace'
description: 'Debug issues in shell scripts with systematic troubleshooting'
tools: ['codebase']
---

# Debug Shell Script Issue

You are helping to debug an issue in a shell script.

## Initial Information Gathering

Ask the user:
1. **What is the problem?**
   - Error messages
   - Unexpected behavior
   - Performance issue
   - Other issue

2. **When does it occur?**
   - Always
   - With specific input
   - In specific environment
   - Intermittently

3. **What is the expected behavior?**

4. **What have you tried so far?**

## Debugging Strategies

### 1. Enable Debug Mode
```bash
# Add to script or run with:
bash -x script.sh

# Or add to script:
set -x  # Enable tracing
set +x  # Disable tracing

# Detailed timing info:
PS4='+ $(date "+%s.%N") ${BASH_SOURCE}:${LINENO}: ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
set -x
```

### 2. Add Logging
```bash
# Use xbashio logging
log_debug "Variable value: ${var}"
log_debug "Entering function: ${FUNCNAME[0]}"
log_debug "Current state: ${state}"

# Enable debug logging
export XBASHIO_DEBUG=true
```

### 3. Check Common Issues

#### Unquoted Variables
```bash
# Problem
filename=$user_input

# Solution
filename="${user_input}"
```

#### Word Splitting
```bash
# Problem
files="file1.txt file2.txt"
for file in $files; do
  echo $file  # Breaks with spaces in names
done

# Solution
files=(file1.txt file2.txt)
for file in "${files[@]}"; do
  echo "${file}"
done
```

#### Pipeline Failures
```bash
# Problem (without pipefail)
cat missing.txt | grep pattern  # Fails silently

# Solution
set -euo pipefail
```

#### Return Code Checking
```bash
# Problem
result=$(command_that_fails)
echo "Result: $result"  # Script continues

# Solution
if result=$(command_that_fails 2>&1); then
  echo "Result: ${result}"
else
  log_error "Command failed: ${result}"
  return 1
fi
```

### 4. Validate Assumptions
```bash
# Check variable values
echo "DEBUG: var=${var:-<unset>}" >&2

# Check file existence
[[ -f "${file}" ]] || log_error "File not found: ${file}"

# Check command availability
command -v jq >/dev/null || log_error "jq not installed"

# Check exit codes
command
echo "DEBUG: Exit code: $?" >&2
```

### 5. Isolate the Problem
```bash
# Comment out sections to find where it fails
# function_call_1
# function_call_2
function_call_3  # If this is uncommented and fails, it's the issue
# function_call_4
```

### 6. Test with Simple Input
```bash
# Instead of complex input:
process_data "simple"

# Then gradually add complexity:
process_data "with spaces"
process_data "with-special-!@#$"
```

## Common Shell Script Issues

### Issue: "command not found"
**Cause:** PATH issue or typo
**Debug:**
```bash
which command_name
echo $PATH
type command_name
```

### Issue: "Permission denied"
**Cause:** Insufficient permissions
**Debug:**
```bash
ls -la file
stat file
id  # Check current user
```

### Issue: "No such file or directory"
**Cause:** Wrong path or file doesn't exist
**Debug:**
```bash
echo "Current dir: $(pwd)"
echo "Script dir: $(dirname "${BASH_SOURCE[0]}")"
ls -la directory
find . -name "filename"
```

### Issue: Variable is empty
**Cause:** Not set or wrong scope
**Debug:**
```bash
set -u  # Fail on undefined variables
echo "Variable: ${var:+set}${var:-unset}"
declare -p var  # Show variable details
```

### Issue: Function not working
**Cause:** Not sourced or wrong scope
**Debug:**
```bash
type -t function_name  # Check if defined
declare -F  # List all functions
```

### Issue: Infinite loop
**Cause:** Loop condition never false
**Debug:**
```bash
# Add iteration counter
count=0
while condition; do
  ((count++))
  if ((count > 100)); then
    log_error "Loop iteration limit exceeded"
    break
  fi
done
```

## Debugging Tools

### shellcheck
```bash
# Check for common issues
shellcheck script.sh

# Ignore specific warnings
# shellcheck disable=SC2086
```

### bash -n
```bash
# Check syntax without running
bash -n script.sh
```

### set options
```bash
set -e  # Exit on error
set -u  # Fail on undefined variable
set -o pipefail  # Catch pipe failures
set -x  # Debug trace
```

## Debugging Checklist

- [ ] Error message captured completely
- [ ] Enable debug mode (set -x)
- [ ] Check variable values at issue point
- [ ] Verify file/command exists
- [ ] Check permissions
- [ ] Validate input data
- [ ] Test with simple input
- [ ] Run shellcheck
- [ ] Check return codes
- [ ] Review recent changes

## Systematic Debugging Process

1. **Reproduce the issue** consistently
2. **Gather information** (error messages, logs)
3. **Form hypothesis** about the cause
4. **Test hypothesis** with minimal changes
5. **Fix the issue** once identified
6. **Verify fix** works
7. **Add test** to prevent regression

## Guidelines

- Follow [bash.instructions.md](../.github/instructions/bash.instructions.md)
- Use systematic approach
- Document findings
- Add tests for bugs
- Share solutions with team

Begin by asking about the issue.
