#!/bin/sh

convert "Source Files/Logo/img001-color.jpg" -crop 5324x3260+0+90 content/logo/img001.jpg

# Favicons
# See https://gist.github.com/pfig/1808188
convert static/images/cm.svg static/images/cm.png
convert static/images/cm.png -resize 128x128 -transparent white static/images/favicon-128.png
convert static/images/favicon-128.png -resize 16x16 static/images/favicon-16.png
convert static/images/favicon-128.png -resize 32x32 static/images/favicon-32.png
convert static/images/favicon-128.png -resize 64x64 static/images/favicon-64.png
convert static/images/favicon-16.png static/images/favicon-32.png static/images/favicon-64.png static/images/favicon-128.png -colors 256 static/images/favicon.ico

# IIIF tiles
WD=`pwd`
cd content/logo
iiif_static.py -d . img001.jpg
cd $WD

# NPM dependencies
yarn install
yarn run svgo
