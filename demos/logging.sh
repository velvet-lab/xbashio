#!/usr/bin/env xbashio
# shellcheck shell=bash
# -*- coding: utf-8 -*-

xbashio::log "This is a default log message."
xbashio::log.blue "This is a blue log message."
xbashio::log.green "This is a green log message."
xbashio::log.yellow "This is a yellow log message."
xbashio::log.red "This is a red log message."
xbashio::log.magenta "This is a magenta log message."
xbashio::log.cyan "This is a cyan log message."

xbashio::log.level all
xbashio::log.trace "This is a trace log message."
xbashio::log.debug "This is a debug log message."
xbashio::log.info "This is an info log message."
xbashio::log.notice "This is a notice log message."
xbashio::log.warning "This is a warning log message."
xbashio::log.error "This is an error log message."
xbashio::log.fatal "This is a fatal log message."

# Set here the Log Level
# Possible Levels: All, Trace, Debug, Info, Notice, Warning, Error, Fatal
xbashio::log.level all

xbashio::log.trace "Trace Logging"
xbashio::log.debug "Debug Logging"
xbashio::log.info "Information Logging"
xbashio::log.notice "Notice Logging"
xbashio::log.warning "Warn Logging"
xbashio::log.error "Error Logging"
xbashio::log.fatal "Fatal Logging"