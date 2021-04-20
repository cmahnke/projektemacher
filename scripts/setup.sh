#!/bin/sh

convert "Source Files/Logo/img001-color.jpg" -crop 5324x3260+0+90 -quality 95 content/logo/img001.jpg
convert -resize 1024x1024 -transparent white -density 600 "Source Files/Logo/Laborant.svg" static/images/laborant.png

# Favicons
# See https://gist.github.com/pfig/1808188

SOURCE="theme/projektemacher-base/images/cm.png" OPTIONS="-transparent white static/images/favicon-128.png" ./themes/projektemacher-base/scripts/favicon.sh

# IIIF tiles
echo "Set SKIP_IIIF to something to disable generation of IIIF derivates"

if [ -z "$SKIP_IIIF" ] ; then
    ./scripts/iiif.sh
else
    echo "Skipping IIIF generation"
fi

# NPM dependencies
yarn install
yarn run svgo
