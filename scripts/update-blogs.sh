#!/usr/bin/env bash

COMPACT=$1

#git submodule init

for BLOG in `ls -1 blogs`
do
  echo "-> Updating $BLOG"
  cd blogs/$BLOG
  if [ -n "$COMPACT" ] ; then
    git fetch --depth=1 origin main
    git reflog expire --expire-unreachable=now --all
    git gc --aggressive --prune=all
  else
    git pull origin main
  fi
  cd ../..
  git add blogs/$BLOG
done
