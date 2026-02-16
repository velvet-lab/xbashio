---
applyTo: "**/*.sh,**/*.bash"
description: "Performance optimization guidelines for shell scripts"
---

# Performance Optimization Guidelines

## General Principles

- Write readable code first, optimize when needed
- Profile before optimizing
- Avoid premature optimization
- Consider maintenance costs vs performance gains

## Minimize Subshells

### Use Built-in Commands Over External Programs
```bash
# GOOD - Built-in parameter expansion
string="${input#prefix}"
string="${input%suffix}"

# AVOID - External command
string="$(echo "${input}" | sed 's/^prefix//')"
```

### Reduce Process Spawning
```bash
# GOOD - Single process
while IFS= read -r line; do
  process "${line}"
done < file.txt

# AVOID - Spawns cat unnecessarily
cat file.txt | while IFS= read -r line; do
  process "${line}"
done
```

## Loop Optimization

### Use Built-in Loops
```bash
# GOOD - Native bash
for i in {1..1000}; do
  echo "$i"
done

# AVOID - Spawns seq
for i in $(seq 1 1000); do
  echo "$i"
done
```

### Avoid Loops When Possible
```bash
# GOOD - Single command
grep -r "pattern" /path

# AVOID - Loop over files
find /path -type f | while read -r file; do
  grep "pattern" "${file}"
done
```

## String Operations

### Use Parameter Expansion
```bash
# GOOD - No external process
filename="${path##*/}"
extension="${filename##*.}"
basename="${filename%.*}"

# AVOID
filename="$(basename "${path}")"
extension="$(echo "${filename}" | cut -d. -f2)"
```

### Concatenate Efficiently
```bash
# GOOD - Let shell handle it
result="${var1}${var2}${var3}"

# AVOID - Multiple subprocesses
result="$(echo "${var1}" | cat)$(echo "${var2}" | cat)$(echo "${var3}" | cat)"
```

## File Operations

### Read Files Efficiently
```bash
# GOOD - Single pass
while IFS=',' read -r col1 col2 col3; do
  process "${col1}" "${col2}" "${col3}"
done < data.csv

# AVOID - Multiple passes
for i in $(seq 1 "$(wc -l < data.csv)"); do
  line="$(sed -n "${i}p" data.csv)"
  process "${line}"
done
```

### Use Appropriate Tools
```bash
# GOOD - Right tool for the job
jq -r '.items[].name' data.json

# AVOID - Line-by-line processing
while IFS= read -r line; do
  echo "${line}" | grep -o '"name":"[^"]*"' | cut -d'"' -f4
done < data.json
```

## Array Usage

### Use Arrays for Collections
```bash
# GOOD - Array
files=()
while IFS= read -r -d '' file; do
  files+=("${file}")
done < <(find . -type f -print0)

for file in "${files[@]}"; do
  process "${file}"
done

# AVOID - String concatenation
files=""
while IFS= read -r file; do
  files="${files} ${file}"
done < <(find . -type f)

for file in ${files}; do  # Word splitting issues
  process "${file}"
done
```

## Conditional Optimization

### Use [[ ]] for Tests
```bash
# GOOD - Built-in conditional
if [[ "${var}" == "value" ]]; then
  action
fi

# AVOID - External process
if test "${var}" = "value"; then
  action
fi
```

### Combine Tests
```bash
# GOOD - Single test
if [[ -f "${file}" && -r "${file}" && -s "${file}" ]]; then
  process "${file}"
fi

# AVOID - Multiple tests
if [[ -f "${file}" ]]; then
  if [[ -r "${file}" ]]; then
    if [[ -s "${file}" ]]; then
      process "${file}"
    fi
  fi
fi
```

## Function Calls

### Minimize Function Call Overhead
```bash
# GOOD - Direct operation
result="${value#prefix}"

# CONSIDER - Only if reused multiple times
strip_prefix() {
  echo "${1#prefix}"
}
result="$(strip_prefix "${value}")"
```

### Use Return Values Instead of Subshells
```bash
# GOOD - Modify variable directly
modify_string() {
  local -n ref=$1
  ref="${ref#prefix}"
}

str="prefixvalue"
modify_string str
echo "${str}"  # "value"

# LESS EFFICIENT - Return via stdout
modify_string() {
  echo "${1#prefix}"
}

str="$(modify_string "prefixvalue")"
```

## Caching and Memoization

### Cache Expensive Operations
```bash
# Cache command check results
declare -A COMMAND_CACHE

command_exists() {
  local cmd="${1}"
  
  if [[ -z "${COMMAND_CACHE[${cmd}]:-}" ]]; then
    if command -v "${cmd}" &>/dev/null; then
      COMMAND_CACHE[${cmd}]=1
    else
      COMMAND_CACHE[${cmd}]=0
    fi
  fi
  
  return "${COMMAND_CACHE[${cmd}]}"
}
```

### Avoid Redundant Calculations
```bash
# GOOD - Calculate once
readonly TIMESTAMP="$(date +%s)"
log_file="${LOG_DIR}/app-${TIMESTAMP}.log"
data_file="${DATA_DIR}/data-${TIMESTAMP}.txt"

# AVOID - Calculate multiple times
log_file="${LOG_DIR}/app-$(date +%s).log"
data_file="${DATA_DIR}/data-$(date +%s).txt"
```

## Parallel Processing

### Use Background Jobs for Independent Tasks
```bash
# Process files in parallel
process_files() {
  local max_jobs=4
  local job_count=0
  
  for file in *.txt; do
    process_file "${file}" &
    
    ((job_count++))
    if ((job_count >= max_jobs)); then
      wait -n  # Wait for any job to finish
      ((job_count--))
    fi
  done
  
  wait  # Wait for remaining jobs
}
```

## Profiling

### Measure Execution Time
```bash
# Time a specific function
time_execution() {
  local start="${SECONDS}"
  "$@"
  local duration=$((SECONDS - start))
  log_debug "Execution time: ${duration}s"
}

time_execution slow_function "args"
```

### Enable Debug Mode for Tracing
```bash
# Add to script for performance debugging
if [[ "${DEBUG:-}" == "true" ]]; then
  set -x
  PS4='+ $(date "+%s.%N") ${BASH_SOURCE}:${LINENO}: ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
fi
```

## Anti-Patterns to Avoid

### Don't Use ls for Parsing
```bash
# GOOD
for file in *.txt; do
  [[ -f "${file}" ]] || continue
  process "${file}"
done

# NEVER
for file in $(ls *.txt); do
  process "${file}"
done
```

### Avoid Useless Use of Cat (UUOC)
```bash
# GOOD
grep "pattern" file.txt

# AVOID
cat file.txt | grep "pattern"
```

### Don't Parse Command Output
```bash
# GOOD - Use appropriate command options
find . -type f -name "*.sh" -exec shellcheck {} +

# AVOID - Parsing ls
for file in $(ls -1 *.sh); do
  shellcheck "${file}"
done
```

## Performance Checklist

Before committing:
- [ ] Minimized subshell usage
- [ ] Used built-in commands over external ones
- [ ] Avoided unnecessary loops
- [ ] Used arrays for collections
- [ ] Cached expensive operations
- [ ] Considered parallel processing for independent tasks
- [ ] No parsing of ls or find output
- [ ] Efficient file reading patterns
