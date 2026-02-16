---
agent: 'workspace'
description: 'Refactor shell scripts to improve quality and maintainability'
tools: ['codebase']
---

# Refactor Shell Script

You are helping to refactor shell scripts in the xbashio project.

## Refactoring Goals

Ask the user what they want to improve:
- [ ] Readability
- [ ] Performance
- [ ] Error handling
- [ ] Security
- [ ] Testability
- [ ] Code duplication
- [ ] Function size
- [ ] Specific issue or smell

## Common Refactoring Patterns

### 1. Extract Function
When a code block is repeated or too long:
```bash
# Before
echo "Processing ${file1}"
process_data "${file1}"
generate_report "${file1}"

echo "Processing ${file2}"
process_data "${file2}"
generate_report "${file2}"

# After
process_file() {
  local file="${1}"
  echo "Processing ${file}"
  process_data "${file}"
  generate_report "${file}"
}

process_file "${file1}"
process_file "${file2}"
```

### 2. Use xbashio Utilities
Replace custom code with library functions:
```bash
# Before
trimmed="$(echo "${input}" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"

# After
trimmed="$(string_trim "${input}")"
```

### 3. Improve Error Handling
Add validation and meaningful errors:
```bash
# Before
function_name() {
  echo "Result from ${1}"
}

# After
function_name() {
  local input="${1:-}"
  
  if [[ -z "${input}" ]]; then
    log_error "Input parameter is required"
    return 1
  fi
  
  echo "Result from ${input}"
}
```

### 4. Eliminate Subshells
Use built-in features:
```bash
# Before
filename="$(basename "${path}")"
extension="$(echo "${filename}" | cut -d. -f2)"

# After
filename="${path##*/}"
extension="${filename##*.}"
```

### 5. Simplify Conditionals
```bash
# Before
if [[ -f "${file}" ]]; then
  if [[ -r "${file}" ]]; then
    if [[ -s "${file}" ]]; then
      process "${file}"
    fi
  fi
fi

# After
if [[ -f "${file}" && -r "${file}" && -s "${file}" ]]; then
  process "${file}"
fi
```

### 6. Use Arrays for Collections
```bash
# Before
files="file1.txt file2.txt file3.txt"
for file in ${files}; do  # Word splitting issues
  process "${file}"
done

# After
files=(file1.txt file2.txt file3.txt)
for file in "${files[@]}"; do
  process "${file}"
done
```

### 7. Add Proper Quoting
```bash
# Before
rm -rf /tmp/$user_input
cat $filename | grep $pattern

# After
rm -rf "/tmp/${user_input}"
grep "${pattern}" "${filename}"
```

### 8. Improve Function Size
Break large functions into smaller ones:
```bash
# Before: One 100-line function

# After: Multiple focused functions
validate_input() { ... }
prepare_data() { ... }
execute_operation() { ... }
cleanup() { ... }

main() {
  validate_input || return 1
  prepare_data
  execute_operation
  cleanup
}
```

## Refactoring Process

1. **Identify code smells:**
   - Long functions (>50 lines)
   - Repeated code blocks
   - Deep nesting (>3 levels)
   - Unclear variable names
   - Missing error handling
   - Performance issues

2. **Plan refactoring:**
   - List specific changes
   - Ensure tests exist first
   - Make changes incrementally

3. **Execute refactoring:**
   - Make one change at a time
   - Run tests after each change
   - Commit working changes

4. **Verify improvements:**
   - All tests still pass
   - Code is more readable
   - Performance maintained or improved
   - No new bugs introduced

## Safety Guidelines

- ✅ DO refactor code with test coverage
- ✅ DO make small, incremental changes
- ✅ DO run tests after each change
- ✅ DO maintain backward compatibility
- ❌ DON'T refactor and add features together
- ❌ DON'T change behavior without tests
- ❌ DON'T make massive changes at once

## Refactoring Checklist

After refactoring:
- [ ] All tests pass
- [ ] shellcheck reports no issues
- [ ] Code is more readable
- [ ] No behavior changes (unless intended)
- [ ] Documentation updated
- [ ] Commit message explains changes

## Guidelines

- Follow [bash.instructions.md](../.github/instructions/bash.instructions.md)
- Maintain existing functionality
- Improve one aspect at a time
- Ensure tests pass throughout
- Document significant changes

Begin by asking what code needs refactoring and what the goals are.
