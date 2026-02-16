---
applyTo: "**/*"
description: "Code review standards and checklist for xbashio"
---

# Code Review Standards

## Review Philosophy

- Be constructive and respectful
- Focus on code, not the author
- Explain the "why" behind suggestions
- Acknowledge good practices
- Ask questions instead of making demands

## What to Review

### Functionality
- [ ] Code implements the required functionality
- [ ] Edge cases are handled
- [ ] Error conditions are properly managed
- [ ] Functions work as documented

### Code Quality
- [ ] Code follows project style guidelines
- [ ] Functions are appropriately sized
- [ ] Naming is clear and consistent
- [ ] Code is readable without excessive comments
- [ ] No code duplication (DRY principle)
- [ ] Uses xbashio utilities where appropriate

### Bash Best Practices
- [ ] Uses `set -euo pipefail`
- [ ] All variables are quoted: `"${var}"`
- [ ] Uses `[[ ]]` for conditionals
- [ ] Uses `local` for function variables
- [ ] Proper shebang: `#!/usr/bin/env bash`
- [ ] Functions have descriptive names
- [ ] Constants are uppercase and readonly

### Security
- [ ] User input is validated
- [ ] No command injection vulnerabilities
- [ ] Paths are validated (no traversal)
- [ ] No hardcoded credentials
- [ ] Temporary files have secure permissions
- [ ] Error messages don't leak sensitive info

### Testing
- [ ] New functionality has Bats tests
- [ ] Tests cover success and failure cases
- [ ] Test names are descriptive
- [ ] All tests pass
- [ ] No hardcoded paths in tests
- [ ] Proper setup/teardown in tests

### Documentation
- [ ] Public functions have complete headers
- [ ] Complex logic has explanatory comments
- [ ] README updated if API changed
- [ ] Breaking changes documented
- [ ] Examples are provided

### Performance
- [ ] No unnecessary subshells
- [ ] Efficient use of loops
- [ ] Built-in commands used over external
- [ ] No premature optimization
- [ ] Reasonable resource usage

## Review Comments Examples

### Good Feedback
```markdown
❓ Question: Could we use `string_trim` from xbashio instead of custom trim function?

💡 Suggestion: Consider adding error handling for the case when file doesn't exist.

✅ Positive: Nice use of parameter expansion here instead of spawning sed!

⚠️ Warning: This creates a security risk because user input isn't validated.

📝 Nit: Variable could be renamed to `output_file` for clarity.
```

### Poor Feedback (Avoid)
```markdown
❌ "This is wrong."
❌ "Why did you do it this way?"
❌ "I wouldn't do it like this."
❌ "This needs to be fixed." (without explanation)
```

## Review Checklist Template

When reviewing a PR, copy this checklist:

```markdown
## Code Review Checklist

### Functionality
- [ ] Implements requirements
- [ ] Handles edge cases
- [ ] Error handling is appropriate

### Code Quality
- [ ] Follows project style
- [ ] Functions are well-sized
- [ ] Clear naming
- [ ] No duplication

### Security
- [ ] Input validation present
- [ ] No injection risks
- [ ] Safe file operations
- [ ] No leaked credentials

### Testing
- [ ] Tests included
- [ ] Tests pass
- [ ] Good coverage

### Documentation
- [ ] Function headers complete
- [ ] README updated if needed
- [ ] Examples provided

### Additional Comments
[Your specific feedback here]
```

## Common Issues to Flag

### Critical Issues (Block Merge)
- Security vulnerabilities
- Command injection risks
- Breaking changes without documentation
- Tests that don't pass
- Hardcoded credentials

### Important Issues (Should Fix)
- Missing input validation
- Poor error handling
- Missing tests for new code
- Unclear or misleading function names
- Files without proper headers

### Minor Issues (Nice to Have)
- Style inconsistencies
- Missing comments on complex logic
- Opportunities for simplification
- Performance optimizations
- Documentation improvements

## Reviewer Responsibilities

### Before Approving
1. Checkout the branch locally
2. Run all tests: `bats tests/`
3. Run shellcheck on modified files
4. Test demo scripts if modified
5. Verify documentation is accurate

### When Requesting Changes
- Be specific about what needs to change
- Explain why the change is necessary
- Suggest alternatives when possible
- Link to relevant documentation

### After Approval
- Ensure all CI checks pass
- Verify no conflicts with main branch
- Consider if release notes are needed

## Author Responsibilities

### Before Requesting Review
- [ ] All tests pass locally
- [ ] Ran shellcheck on changed files
- [ ] Updated documentation
- [ ] Added/updated tests
- [ ] Self-reviewed the changes
- [ ] Rebased on latest main

### Responding to Feedback
- Respond to all comments
- Ask for clarification if needed
- Explain your reasoning when disagreeing
- Mark resolved conversations
- Thank reviewers for their time

## GitHub Review Guidelines

### Using GitHub Review Features
- Use "Request changes" for blocking issues
- Use "Approve" when changes look good
- Use "Comment" for questions or minor suggestions
- Resolve conversations when addressed
- Re-review after changes

### PR Description Template
```markdown
## Description
Brief description of changes.

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
How has this been tested?

## Checklist
- [ ] Code follows project style
- [ ] Tests added/updated
- [ ] Documentation updated
- [ ] All tests pass
- [ ] shellcheck clean
```

## Review Turnaround Time

- Initial review within 1-2 business days
- Follow-up reviews within 1 business day
- Urgent fixes reviewed within 4 hours

## Escalation

When to escalate:
- Disagreement on architecture decisions
- Security concerns
- Breaking changes requiring wider discussion
- Uncertainty about best approach
