#!/bin/sh

for BLOG in `ls -1 blogs`
do
    echo "Cleaning $BLOG"
    rm -rf blogs/$BLOG/docs/* blogs/$BLOG/resources/_gen/*
    find blogs/$BLOG/content -name info.json -print -exec dirname {} \; | xargs rm -r
done

rm -rf docs/* resources/_gen/*
