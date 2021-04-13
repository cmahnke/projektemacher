#!/bin/sh

for BLOG in `ls -1 blogs`
do
    if [ -x "$BLOG/scripts/cleanup.sh" ] ; then
        echo "Cleaning $BLOG"
        $BLOG/scripts/cleanup.sh
    fi
done

rm -rf docs/* resources/_gen/* static/images/favicon*
