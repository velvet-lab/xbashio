#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# ------------------------------------------------------------------------------
# Creates a new User
#
# Arguments:#
#   $1 User Name to create
#   $2 Password for the new User
# ------------------------------------------------------------------------------
devoxio::security.createUser() {
    local user="${1:-}"
    local password="${2:-}"
    local min_user_id=4999

    devoxio::log.trace "${FUNCNAME[0]}:" "$@"
    devoxio::log.info "Create User '${user}'"

    if ! devoxio::var.has_value "$user"; then
        devoxio::log.error "No User given"
        return "${__DEVOXIO_EXIT_NOK}"
    fi

    if ! devoxio::var.has_value "$password"; then
        devoxio::log.error "No Password given"
        return "${__DEVOXIO_EXIT_NOK}"
    fi

    user_exists=$(getent passwd "${user}" || true)
    if devoxio::var.is_empty "${user_exists}"; then
        devoxio::log.info "User '${user}' does not exists. It will created now"

        ids=()
        mapfile -t ids < <(getent passwd | cut -d ":" -f3)

        devoxio::log.trace "Look for the hightest available Number ..."
        for i in "${ids[@]}"; do
            id=$((min_user_id + 0))
            if [ $((i + 0)) -gt $((min_user_id + 0)) ]; then
                id=$i
            fi
        done

        devoxio::log.trace "Highest ID is '$id'"

        devoxio::log.trace "Increment User Id '$id' ..."
        id=$((id + 1))

        encryptedPassword=$(devoxio::security.encryptPassword "$password")

        devoxio::log.trace "Create an new Group with ID '$id' ..."
        groupadd -g $id -p "$encryptedPassword" "$user" > /dev/null 2>&1 || devoxio::exit.nok "Group '$user' could not created"

        devoxio::log.trace "Create a new User with ID '$id' ..."
        useradd -s /bin/bash -u $id -g $id -p "$encryptedPassword" -m "$user" >/dev/null 2>&1 || devoxio::exit.nok "User '$user' could not created"

        devoxio::security.writeSecurityLog "User '${user}' created with '$password'"

        devoxio::log.info "User '$user' and Group created."
    else
        devoxio::log.info "User '$user' already exists. Nothing to do."
    fi

    return "${__DEVOXIO_EXIT_OK}"
}

# ------------------------------------------------------------------------------
# Delete a User
#
# Arguments:
#   $1 User to delete
# ------------------------------------------------------------------------------
devoxio::security.deleteUser() {
    local user="${1:-}"

    devoxio::log.trace "${FUNCNAME[0]}:" "$@"
    devoxio::log.info "Delete User '${user}'"

    if ! devoxio::var.has_value "$user"; then
        devoxio::log.error "No User given"
        return "${__DEVOXIO_EXIT_NOK}"
    fi

    user_exists=$(getent passwd "${user}" || true)
    if devoxio::var.has_value "${user_exists}"; then
        userdel -f "$user" >/dev/null 2>&1 || devoxio::exit:nok "User '$user' could not removed"

        devoxio::security.writeSecurityLog "User '${user}' deleted"
    else
        devoxio::log.info "User '$user' not exists"
    fi

    return "${__DEVOXIO_EXIT_OK}"
}

# ------------------------------------------------------------------------------
# Delete a Group
#
# Arguments:
#   $1 Group to delete
# ------------------------------------------------------------------------------
devoxio::security.deleteGroup() {
    local group="${1:-}"

    devoxio::log.trace "${FUNCNAME[0]}:" "$@"
    devoxio::log.info "Delete Group '${group}'"

    if ! devoxio::var.has_value "$user"; then
        devoxio::log.error "No Group given"
        return "${__DEVOXIO_EXIT_NOK}"
    fi

    group_exists=$(getent group "${group}" || true)
    if devoxio::var.has_value "${group_exists}"; then
        groupdel "$group" >/dev/null 2>&1 || devoxio::exit:nok "Group '$group' could not removed"

        devoxio::security.writeSecurityLog "Group '${group}' deleted"
    else
        devoxio::log.info "Group '$group' not exists"
    fi

    return "${__DEVOXIO_EXIT_OK}"
}

# ------------------------------------------------------------------------------
# Adds a User to Group
#
# Arguments:
#   $1 User to add
#   $2 Group where the User will addes
# ------------------------------------------------------------------------------
devoxio::security.addUserToGroup() {
    local user="${1:-}"
    local group="${2:-}"

    devoxio::log.trace "${FUNCNAME[0]}:" "$@"

    devoxio::log.info "Add User '${user}' to Group '${group}'"

    if ! devoxio::var.has_value "$user"; then
        devoxio::log.error "No User given"
        return "${__DEVOXIO_EXIT_NOK}"
    fi

    if ! devoxio::var.has_value "$group"; then
        devoxio::log.error "No Group given"
        return "${__DEVOXIO_EXIT_NOK}"
    fi

    user_already_added=$(getent group "$group" | grep -i "$user" || true)
    if ! devoxio::var.has_value "$user_already_added"; then
        usermod -aG "$group" "$user" >/dev/null 2>&1 || devoxio::exit.nok "User '$user' could not added to Group '$group'"

        devoxio::security.writeSecurityLog "User '${user}' added to Group '${group}'"
    else
        devoxio::log.info "User '$user' already added to Group '$group'"
    fi

    return "${__DEVOXIO_EXIT_OK}"
}

# ------------------------------------------------------------------------------
# Removes a User from Group
#
# Arguments:
#   $1 User to add
#   $2 Group where the User will addes
# ------------------------------------------------------------------------------
devoxio::security.removeUserFromGroup() {
    local user="${1:-}"
    local group="${2:-}"

    devoxio::log.trace "${FUNCNAME[0]}:" "$@"

    devoxio::log.info "Remove User '${user}' from Group '${group}'"

    if ! devoxio::var.has_value "$user"; then
        devoxio::log.error "No User given"
        return "${__DEVOXIO_EXIT_NOK}"
    fi

    if ! devoxio::var.has_value "$group"; then
        devoxio::log.error "No Group given"
        return "${__DEVOXIO_EXIT_NOK}"
    fi

    user_exists=$(getent group "$group" | grep -i "$user" || true)
    if devoxio::var.has_value "$user_exists"; then
        gpasswd -d "$user" "$group" >/dev/null 2>&1 || devoxio::exit.nok "User '$user' could not removed from Group"
        devoxio::security.writeSecurityLog "User '${user}' removed from Group '${group}'"
    else
        devoxio::log.info "User '$user' already removed from Group '$group'"
    fi

    return "${__DEVOXIO_EXIT_OK}"
}

# ------------------------------------------------------------------------------
# Creates a random unencrypted Password
#
# Arguments:
#   $1 Length of the Password (default is 24)
# ------------------------------------------------------------------------------
# shellcheck disable=SC2120
devoxio::security.createPassword() {
    local length="${1:-24}"

    devoxio::log.trace "${FUNCNAME[0]}:" "$@"

    devoxio::log.info "Create a random Password"
    plain=$(tr -dc A-Za-z0-9 </dev/urandom | head -c "$length" ; echo '')

    echo -e "$plain"
}

# ------------------------------------------------------------------------------
# Encrypt a given Password
#
# Arguments:
#   $1 Password
# ------------------------------------------------------------------------------
devoxio::security.encryptPassword() {
    local password="${1:-}"

    devoxio::log.trace "${FUNCNAME[0]}:" "$@"

    devoxio::log.info "Encrypt given Password"

    if ! devoxio::var.has_value "$password"; then
        devoxio::log.error "No Password given"
        return "${__DEVOXIO_EXIT_NOK}"
    fi

    openssl passwd -1 "${password}"
}

# ------------------------------------------------------------------------------
# Disable Root User
#
# ------------------------------------------------------------------------------
devoxio::security.disableRoot() {

    devoxio::log.trace "${FUNCNAME[0]}:"

    devoxio::log.info "Create a random Password"
    password=$(devoxio::security.createPassword 24)
    devoxio::security.changePassword root "$password"

    devoxio::security.writeSecurityLog "User 'root' disabled. New password is '${password}'"
}

# ------------------------------------------------------------------------------
# Change Password for a User
#
# Arguments:
#   $1 User where the Password should changed
#   $2 New Password
#   $3 Old Password
# ------------------------------------------------------------------------------
devoxio::security.changePassword() {
    local user="${1:-}"
    local newpassword="${2:-}"
    local oldpassword="${3:-}"

    devoxio::log.trace "${FUNCNAME[0]}:" "$user"

    devoxio::log.info "Change Password for User '$user'"

    if ! devoxio::var.has_value "$user"; then
        devoxio::log.error "No User given"
        return "${__DEVOXIO_EXIT_NOK}"
    fi

    if ! devoxio::var.has_value "$newpassword"; then
        devoxio::log.error "New Password is missing"
        return "${__DEVOXIO_EXIT_NOK}"
    fi

    devoxio::log.info "Change Password for User '$user'"
    if devoxio::var.has_value "$oldpassword"; then
        (echo -e "${oldpassword}\n${newpassword}\n${newpassword}" | passwd "$user") || devoxio::exit.nok "Password for User '$user' could not changed"
    else
        (echo -e "${newpassword}\n${newpassword}" | passwd "$user") || devoxio::exit.nok "Password for User '$user' could not changed"
    fi

    return "${__DEVOXIO_EXIT_OK}"
}

# ------------------------------------------------------------------------------
# Writes Security Infos to a File
#
# Arguments:
#   $1 The info
# ------------------------------------------------------------------------------
devoxio::security.writeSecurityLog(){
    local item="${1:-}"

    devoxio::log.trace "${FUNCNAME[0]}:"

    if [ -n "$item" ]; then
        cat >> "/root/.devoxio-security" << EOF
$(date +'%Y%m%d_%H%M%S') -> $item
EOF
    fi

    return "${__DEVOXIO_EXIT_OK}"
}

# ------------------------------------------------------------------------------
# Remove Garbage Files
#
# ------------------------------------------------------------------------------
devoxio::security.clean(){

    devoxio::log.trace "${FUNCNAME[0]}:"

    devoxio::log.info "Cleanup Security Log"

    rm -f /root/.devoxio-security || true
    rm -f /root/.devoxio_security || true
}

# ------------------------------------------------------------------------------
# Update root certificates
#
# ------------------------------------------------------------------------------
devoxio::security.updateCA(){

    devoxio::log.trace "${FUNCNAME[0]}:"

    devoxio::log.info "Update Certificates"
    update-ca-certificates
}