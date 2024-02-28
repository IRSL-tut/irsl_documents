#!/bin/bash

set -e

_DO_COPY=${DO_COPY:-""}
_COMMIT_MESSAGE=${COMMIT_MESSAGE:-"Updated by script.sh"}
_USER_NAME=${USER_NAME:-"IRSL-tut"}
_USER_EMAIL=${USER_EMAIL:-"faculty@irsl.eiiris.tut.ac.jp"}

echo "#### make html ####"
make html

echo "#### make gettext ####"
make gettext

echo "#### sphinx-intl update -p _build/gettext -l ja ####"
sphinx-intl update -p _build/gettext -l ja

echo "#### make html -e SPHINXOPTS='-D language=ja' -e BUILDDIR=ja_build ####"
make html -e SPHINXOPTS='-D language=ja' -e BUILDDIR=ja_build

if [ $(git diff | wc -l) -gt 0 ]; then
    echo "#### commit changes ####"
    ### require to be committed
    git -c user.name=${_USER_NAME} -c user.email=${_USER_EMAIL} commit -a  -m "'${_COMMIT_MESSAGE}'"
fi

if [ -n "${_DO_COPY}" ]; then
    echo "#### git checkout gh-pages ####"
    git checkout gh-pages
    echo "#### COPY ####"
    cp -r _build/html/. ../docs
    mkdir -p ../docs/ja
    cp -r ja_build/html/. ../docs/ja

    echo "#### Finish updating gh-pages branch, please commit and make pull-request for contributions"
    echo "#### WARNING: branch might be reverted ( ./reset.sh ) ####"
fi
