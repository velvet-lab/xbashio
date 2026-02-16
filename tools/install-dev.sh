#!/usr/bin/env bash
# -*- coding: utf-8 -*-

basedir="${1:-$HOME/.local}"

# cleanup old install if exists
rm -rf "$basedir"/lib/xbashio || true
rm -f "$basedir"/bin/xbashio || true

mkdir -p "$basedir"/lib
mkdir -p "$basedir"/bin

ln -s "$PWD"/../lib/xbashio/src "$basedir"/lib/xbashio
ln -s "$basedir"/lib/xbashio/xbashio "$basedir"/bin/xbashio

chmod -R 755 "$basedir"/bin/xbashio