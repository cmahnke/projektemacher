#!/usr/bin/env bash

#git submodule init

for BLOG in `ls -1 blogs`
do
  if [ -d blogs/$BLOG/themes/projektemacher-base ] ; then
    cd blogs/$BLOG/themes/projektemacher-base
    echo "Updating 'projektemacher-base' theme for ${BLOG}"
    git pull origin main
    cd ../../../..
  fi
done
