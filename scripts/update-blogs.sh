#!/usr/bin/env bash

#git submodule init

for BLOG in `ls -1 blogs`
do
  echo "-> Updating $BLOG"
  cd blogs/$BLOG
  git pull origin main
  cd ../..
  git add blogs/$BLOG
done
