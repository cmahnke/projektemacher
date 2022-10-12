#!/usr/bin/env bash

#git submodule init

for BLOG in `ls -1 blogs`
do
  cd blogs/$BLOG
  git pull
  cd ../..
done
