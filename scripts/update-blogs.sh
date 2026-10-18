#!/usr/bin/env bash

#git submodule init

for BLOG in `ls -1 blogs`
do
  echo "-> Updating $BLOG"
  cd blogs/$BLOG
  if ! git fetch origin main ; then
    echo "Fetch failed for $BLOG, skipping"
    cd ../..
    continue
  fi
  # Safety net: if the current state differs from origin/main, keep it reachable
  if [ "$(git rev-parse HEAD)" != "$(git rev-parse origin/main)" ] ; then
    git update-ref refs/backups/$(date +%Y%m%d-%H%M%S) HEAD
    echo "Warning: '$BLOG' was not at origin/main (was $(git rev-parse --short HEAD)), created backup ref"
  fi
  git checkout -B main origin/main
  git submodule update --init --recursive
  cd ../..
  git add blogs/$BLOG
done
