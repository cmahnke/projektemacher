#!/bin/bash

SECTIONS=$(git config --file .gitmodules -l --name-only |sed -E 's/^[^\0][^\.]*\.([^\0]*)\.[^\0][^\.]*$/\1/g')

SECTIONS=`echo $SECTIONS | tr '\n' ':'`

CTX=`pwd`

for SECTION in $SECTIONS
do
    if [[ "$SECTION" =~ ^blogs.* ]]; then
        echo "Processing $SECTION"
    else
        continue
    fi

    MODULE_PATH=$(git config --file .gitmodules --get "submodule.$SECTION.path")
    MODULE_URL=$(git config --file .gitmodules --get "submodule.$SECTION.url")

    cd $MODULE_PATH
    echo "Checking out $MODULE_URL to $MODULE_PATH"
    git clone $URL --filter=blob:limit=1m --depth 1 $MODULE_URL .
    cd $CTX
done
