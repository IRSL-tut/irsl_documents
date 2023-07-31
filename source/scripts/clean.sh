#!/bin/bash

### clean generated files

# set -e

echo "#### rm locales/ja/LC_MESSAGES/*.mo ####"
rm locales/ja/LC_MESSAGES/*.mo

echo "#### rm -rf _build ####"
rm -rf _build

echo "#### rm -rf ja_build ####"
rm -rf ja_build
