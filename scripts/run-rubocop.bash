#!/usr/bin/env bash

set -e

cd "${0%/*}/.."

echo "Running rubocop"
# https://hanamimastery.com/episodes/23-rubocop-most-frustrating-to-most-loved
git ls-files -m | xargs ls -1 2>/dev/null | grep '\.rb$' | xargs -rt rubocop
