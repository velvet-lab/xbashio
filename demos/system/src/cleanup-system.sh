#!/usr/bin/env xbashio
# -*- coding: utf-8 -*-
# shellcheck shell=bash

# Set Log Level
xbashio::log.level trace

xbashio::log.info "Cleanup the System"
xbashio::trash.clean
