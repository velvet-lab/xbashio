---
applyTo: "**/*.sh,**/*.bash"
description: "Security best practices for shell scripting in xbashio"
---

# Security Best Practices

## Input Validation

### Always Validate User Input
- Never trust external input
- Validate data types (numbers, paths, etc.)
- Sanitize input before using in commands
- Check for injection attempts

```bash
# GOOD
validate_input() {
  local input="${1:-}"
  
  if [[ -z "${input}" ]]; then
    log_error "Input cannot be empty"
    return 1
  fi
  
  if [[ ! "${input}" =~ ^[a-zA-Z0-9_-]+$ ]]; then
    log_error "Invalid characters in input"
    return 1
  fi
}

# BAD - No validation
function_name() {
  rm -rf "/tmp/${1}"  # Dangerous!
}
```

## Command Injection Prevention

### Quote All Variables
```bash
# GOOD
filename="${user_input}"
cat "${filename}"

# BAD - Command injection possible
filename=${user_input}
cat $filename
```

### Avoid eval and Dynamic Command Construction
```bash
# GOOD
if [[ "${action}" == "start" ]]; then
  start_service
elif [[ "${action}" == "stop" ]]; then
  stop_service
fi

# BAD - Command injection risk
eval "${action}_service"
```

## Path Safety

### Use Absolute Paths
```bash
# GOOD
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly CONFIG_FILE="${SCRIPT_DIR}/config.conf"

# BAD - Relative paths can be manipulated
CONFIG_FILE="./config.conf"
```

### Validate Paths Before Use
```bash
validate_path() {
  local path="${1}"
  
  # Prevent directory traversal
  if [[ "${path}" =~ \.\. ]]; then
    log_error "Path traversal detected"
    return 1
  fi
  
  # Ensure path is within allowed directory
  local allowed_dir="/var/lib/xbashio"
  local real_path="$(realpath -m "${path}")"
  
  if [[ ! "${real_path}" =~ ^${allowed_dir} ]]; then
    log_error "Path outside allowed directory"
    return 1
  fi
}
```

## Credential Management

### Never Hardcode Credentials
```bash
# GOOD - Use environment variables or secure vaults
readonly API_KEY="${XBASHIO_API_KEY:-}"
if [[ -z "${API_KEY}" ]]; then
  log_error "API_KEY environment variable not set"
  exit 1
fi

# BAD - Hardcoded credentials
API_KEY="secret12345"
```

### Don't Log Sensitive Data
```bash
# GOOD
log_info "Authentication successful for user: ${username}"

# BAD
log_debug "Password: ${password}"  # Never do this!
```

### Secure Temporary Files
```bash
# GOOD
readonly TEMP_FILE="$(mktemp)"
trap 'rm -f "${TEMP_FILE}"' EXIT
chmod 600 "${TEMP_FILE}"  # Only owner can read/write
echo "${sensitive_data}" > "${TEMP_FILE}"

# BAD - World-readable temp file
echo "${sensitive_data}" > /tmp/myfile.txt
```

## File Operations

### Check File Permissions
```bash
check_file_security() {
  local file="${1}"
  
  # Check if file is owned by current user
  if [[ ! -O "${file}" ]]; then
    log_error "File not owned by current user"
    return 1
  fi
  
  # Check if file is world-writable
  if [[ -w "${file}" && ! -O "${file}" ]]; then
    log_warning "File is world-writable"
  fi
}
```

### Safe File Downloads
```bash
download_file() {
  local url="${1}"
  local dest="${2}"
  
  # Validate URL format
  if [[ ! "${url}" =~ ^https:// ]]; then
    log_error "Only HTTPS URLs are allowed"
    return 1
  fi
  
  # Download to temporary file first
  local temp_file="$(mktemp)"
  trap 'rm -f "${temp_file}"' RETURN
  
  if curl -fsSL "${url}" -o "${temp_file}"; then
    # Verify download (checksum, signature, etc.)
    mv "${temp_file}" "${dest}"
    chmod 644 "${dest}"
  else
    log_error "Download failed"
    return 1
  fi
}
```

## Process Security

### Avoid Subprocess Shells When Possible
```bash
# GOOD - Direct command execution
output="$(date +%Y-%m-%d)"

# AVOID - Subprocess shell
output="$(sh -c 'date +%Y-%m-%d')"
```

### Set Restrictive Umask
```bash
# Set restrictive default permissions
umask 077  # Files: 600, Dirs: 700
```

## Network Operations

### Use TLS/SSL
- Always use HTTPS for downloads
- Verify certificates
- Don't disable certificate verification

```bash
# GOOD
curl -fsSL "https://example.com/file" -o file

# BAD
curl -k "http://example.com/file" -o file  # Insecure!
```

## SSH Operations

### SSH Key Management
```bash
create_ssh_key() {
  local key_path="${1}"
  local email="${2}"
  
  # Validate inputs
  validate_path "${key_path}" || return 1
  
  # Generate key with strong algorithm
  ssh-keygen -t ed25519 -C "${email}" -f "${key_path}" -N ""
  
  # Set restrictive permissions
  chmod 600 "${key_path}"
  chmod 644 "${key_path}.pub"
  
  log_success "SSH key created with secure permissions"
}
```

## Security Checklist

Before committing code:
- [ ] All user input is validated
- [ ] Variables are quoted
- [ ] No eval or command injection risks
- [ ] Paths are validated for traversal
- [ ] No hardcoded credentials
- [ ] Temporary files have secure permissions
- [ ] Error messages don't leak sensitive info
- [ ] HTTPS used for all network operations
- [ ] File permissions are appropriately restrictive
- [ ] No world-writable files created
