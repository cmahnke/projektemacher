#!/bin/sh

# Indexing
node scripts/build-index.js

#rm -r docs/blog/*
find docs/ -name 'index.json' -exec rm {} \;
