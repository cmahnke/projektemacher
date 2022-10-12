#!/usr/bin/env bash

#git submodule init

for BLOG in `ls -1 blogs`
do
  cd blogs/$BLOG
  git submodule update --init --recursive
  ./scripts/setup.sh
  cd ../..
done
