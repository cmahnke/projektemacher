#!/bin/sh

# Indexing
node scripts/build-index.js

find  docs/post -type d -mindepth 2 -exec rm -rf {} \;
find docs/ -name 'index.json' -exec rm {} \;
