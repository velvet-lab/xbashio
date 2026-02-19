# Private recipe to print colored messages
[private]
[no-quiet]
info message:
    @echo "{{BLUE}}{{message}}{{NORMAL}}"

[private]
[no-quiet]
success message:
    @echo "{{GREEN}}{{message}}{{NORMAL}}"

[private]
[no-quiet]
warning message:
    @echo "{{YELLOW}}{{message}}{{NORMAL}}"

[private]
[no-quiet]
fatal message:
    @echo "{{RED}}{{message}}{{NORMAL}}"
    exit 1

[private]
default-recipe:
    just --list
