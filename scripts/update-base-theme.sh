#!/usr/bin/env bash

#git submodule init

for BLOG in `ls -1 blogs`
do
  if [ -d blogs/$BLOG/themes/projektemacher-base ]
  cd blogs/$BLOG/themes/projektemacher-base
  git pull
  cd ../../../..
done
