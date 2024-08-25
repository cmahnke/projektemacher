#!/usr/bin/env bash

convert "Source Files/Logo/img001-color.jpg" -crop 5324x3260+0+90 -quality 95 content/logo/img001.jpg
convert -resize 1024x1024 -transparent white -density 600 "Source Files/Logo/Laborant.svg" static/images/laborant.png

# Favicons
# See https://gist.github.com/pfig/1808188

SOURCE="themes/projektemacher-base/static/images/cm.svg" OPTIONS="-transparent white static/images/favicon-128.png" ./themes/projektemacher-base/scripts/favicon.sh

cp themes/projektemacher-base/static/images/cm.svg static/image/
sed -i 's/fill-opacity:0.5/fill-opacity:1.0/g' static/image/cm.svg
convert -density 2400 static/image/cm.svg static/images/cm-monogram.png

# IIIF tiles
echo "Set SKIP_IIIF to something to disable generation of IIIF derivates"

#NPM dependencies
echo "Calling theme scripts"
for SCRIPT in $PWD/themes/projektemacher-base/scripts/init/*.sh ; do
    echo "Running $SCRIPT"
    bash "$SCRIPT"
    ERR=$?
    if [ $ERR -ne 0 ] ; then
        echo "Execution of '$SCRIPT' failed!"
        exit $ERR
    fi
done

if [ -z "$SKIP_IIIF" ] ; then
    ./scripts/iiif.sh
else
    echo "Skipping IIIF generation"
fi

# NPM dependencies
yarn install
yarn run svgo
