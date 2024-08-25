#!/usr/bin/env bash

git submodule update --init --depth 1 -j 4 themes/*
for dir in `ls blogs/`; do
  echo "Checking out submodule blogs/$dir" ;
  git submodule update --depth 1 -j 4 --init blogs/$dir ;
  rm -rf blogs/$dir/.git ;
  find blogs/$dir -type f -size +1M \( -name '*.jpg' -o -name '*.jxl' \) -print -exec rm {} \;
done
