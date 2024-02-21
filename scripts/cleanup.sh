#!/usr/bin/env bash

for BLOG in `ls -1 blogs`
do
    if [ -x "blogs/$BLOG/scripts/cleanup.sh" ] ; then
        echo "Cleaning $BLOG"
        blogs/$BLOG/scripts/cleanup.sh
        $(cd blogs/$BLOG && git branch -d gh-pages)
    fi
done

./themes/projektemacher-base/scripts/cleanup.sh
rm -rf docs/* resources/_gen/* static/images/favicon*
