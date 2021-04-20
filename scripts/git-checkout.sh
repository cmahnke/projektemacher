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
    MODULE_REF=$(git submodule status $SECTION|sed -E 's/[-+ ]{1}((.|\n|\r){40})(.|\n|\r)*/\1/g')

    mkdir -p $MODULE_PATH
    cd $MODULE_PATH
    echo "Checking out $MODULE_URL to $MODULE_PATH"
    # See https://github.blog/2020-01-17-bring-your-monorepo-down-to-size-with-sparse-checkout/
    git clone $URL --sparse --filter=blob:none --no-checkout $MODULE_URL .
    git sparse-checkout init --cone
    git sparse-checkout set '!/* post/**/*.md'
    git checkout $MODULE_REF
    cd $CTX
done
