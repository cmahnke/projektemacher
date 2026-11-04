#!/usr/bin/env bash

python themes/projektemacher-base/scripts/post-calendar.py > docs/projektemacher.ics

find docs/post -type d -mindepth 2 -exec rm -rf {} \;
find docs/ -name 'index.json' -exec rm {} \;
rm -rf docs/tags/*
