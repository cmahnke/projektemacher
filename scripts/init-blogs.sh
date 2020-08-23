#!/bin/sh

#git submodule init

for BLOG in `ls -1 blogs`
do
  cd blogs/$BLOG
  git submodule init
  ./scripts/setup.sh
  cd ../..
done
