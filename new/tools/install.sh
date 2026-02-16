#!/usr/bin/env bash
# -*- coding: utf-8 -*-

basedir="${1:-$HOME/.local}"

# cleanup old install if exists
if [ -d "$basedir"/lib/devoxio ]; then
    rm -rf "$basedir"/lib/devoxio || true
    rm -f "$basedir"/bin/devoxio || true
fi

# create new folders
mkdir -p "$basedir"/lib/devoxio

# install files
cp -Rf ../src/* "$basedir"/lib/devoxio
chmod -R 755 "$basedir"/lib/devoxio/*

ln -s "$basedir"/lib/devoxio/devoxio "$basedir"/bin/devoxio
chmod -R 755 "$basedir"/bin/devoxio