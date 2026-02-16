#!/usr/bin/env bash
# -*- coding: utf-8 -*-

version="1.0.1"
file=xbashio-"${version}".tar.gz
url="https://github.com/velvet-lab/xbashio/archive/${version}.tar.gz"

apt update && apt install -qy --no-install-recommends curl
curl -fSL "$url" --output /tmp/"${file}"

rm -rf /usr/lib/xbashio || true
rm -f /usr/bin/xbashio || true
rm -rf /usr/local/lib/xbashio || true
rm -f /usr/local/bin/xbashio || true

mkdir -p /usr/local/lib/xbashio

tar -xvzf /tmp/"${file}" --directory /tmp

mv /tmp/xbashio/lib//xbashio/src/* /usr/local/lib/xbashio
chmod 755 /usr/local/lib/xbashio/*

ln -s /usr/local/lib/xbashio/xbashio /usr/local/bin/xbashio
chmod 755 /usr/local/bin/xbashio
rm -rf /tmp/xbashio*
