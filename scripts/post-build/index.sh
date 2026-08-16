#!/usr/bin/env bash

set -e

if [ -z "$(which python)" ] ; then
  echo "Python interpreter not installed, exiting!"
  exit 1
else
  PYTHON=`which python`
fi

LOG_LEVEL=INFO
export LOG_LEVEL

pagefind-indexer -c pagefind-index.yaml
#$PYTHON themes/projektemacher-base/scripts/indexer.py -c pagefind-index.yaml
