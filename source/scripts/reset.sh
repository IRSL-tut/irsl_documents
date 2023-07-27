#!/bin/bash

set -e

_BRANCH=${BRANCH:-"main"}

echo "#### git checkout ../docs ####"
git checkout ../docs

echo "#### git checkout main ####"
git checkout ${_BRANCH}
