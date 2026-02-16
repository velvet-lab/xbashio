#!/usr/bin/env bash
# -*- coding: utf-8 -*-

basedir="${1:-$HOME/.local}"

# cleanup old install if exists
if [ -d "$basedir"/lib/xbashio ]; then
    rm -rf "$basedir"/lib/xbashio || true
    rm -f "$basedir"/bin/xbashio || true
fi

# create new folders
mkdir -p "$basedir"/lib/xbashio

# install files
cp -Rf ../src/* "$basedir"/lib/xbashio
chmod -R 755 "$basedir"/lib/xbashio/*

ln -s "$basedir"/lib/xbashio/xbashio "$basedir"/bin/xbashio
chmod -R 755 "$basedir"/bin/xbashio