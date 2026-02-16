#!/usr/bin/env bash
# -*- coding: utf-8 -*-

basedir="${1:-$HOME/.local}"

# cleanup old install if exists
rm -rf "$basedir"/lib/devoxio || true
rm -f "$basedir"/bin/devoxio || true

ln -s "$PWD"/../src/devoxio "$basedir"/bin/devoxio
chmod -R 755 "$basedir"/bin/devoxio