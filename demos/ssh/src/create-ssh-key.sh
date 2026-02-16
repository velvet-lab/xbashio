#!/usr/bin/env xbashio
# -*- coding: utf-8 -*-
# shellcheck shell=bash

xbashio::log.info "Create ssh Keys"
xbashio::ssh.createKey "$1"
