#!/bin/bash

set -e

_DO_COPY=${DO_COPY:-""}

echo "#### make html ####"
make html

echo "#### make gettext ####"
make gettext

echo "#### sphinx-intl update -p _build/gettext -l ja ####"
sphinx-intl update -p _build/gettext -l ja

echo "#### make html -e SPHINXOPTS='-D language=ja' -e BUILDDIR=ja_build ####"
make html -e SPHINXOPTS='-D language=ja' -e BUILDDIR=ja_build

if [ -n "${_DO_COPY}" ]; then
    echo "#### git checkout gh-pages ####"
    git checkout gh-pages
    echo "#### COPY ####"
    cp -r _build/html/. ../docs
    cp -r ja_build/html/. ../docs/ja

    echo "#### WARNING: branch might be changed ( ./reset.sh ) ####"
fi
