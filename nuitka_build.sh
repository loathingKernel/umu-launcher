#!/usr/bin/bash

python -m venv venv_nuitka
source venv_nuitka/bin/activate
pip install -r requirements.in
pip install nuitka
./configure.sh --user-install
make version

nuitka_opts=(
    '--assume-yes-for-downloads'
    '--show-scons'
    '--lto=no'
    '--jobs=4'
    '--static-libpython=no'
    '--standalone'
    '--enable-plugin=anti-bloat'
    '--show-modules'
    '--show-anti-bloat-changes'
    '--follow-stdlib'
    '--follow-imports'
    '--nofollow-import-to="*.tests"'
    '--nofollow-import-to="*.distutils"'
    '--nofollow-import-to="distutils"'
    '--nofollow-import-to="unittest"'
    '--nofollow-import-to="pydoc"'
    '--nofollow-import-to="tkinter"'
    '--nofollow-import-to="test"'
    '--prefer-source-code'
    '--include-package=Xlib'
    '--include-package=filelock'
    '--include-data-files=umu/umu_version.json=umu_version.json'
)

python -m nuitka "${nuitka_opts[@]}" umu

find umu.dist -iname "*.so*" -type f -exec strip --strip-unneeded {} \;
strip --strip-unneeded umu.dist/umu.bin

deactivate
rm -rf venv_nuitka

