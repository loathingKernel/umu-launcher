#!/usr/bin/bash

python -m nuitka \
--assume-yes-for-downloads \
--mingw64 \
--lto=no \
--jobs=2 \
--static-libpython=yes \
--standalone \
--enable-plugin=anti-bloat \
--show-modules \
--show-anti-bloat-changes \
--follow-stdlib \
--follow-imports \
--nofollow-import-to="*.tests" \
--nofollow-import-to="*.distutils" \
--nofollow-import-to="distutils" \
--nofollow-import-to="unittest" \
--nofollow-import-to="pydoc" \
--nofollow-import-to="tkinter" \
--nofollow-import-to="test" \
--prefer-source-code \
--include-package=Xlib \
--include-data-files=umu/umu_version.json=umu_version.json \
umu
