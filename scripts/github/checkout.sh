#!/usr/bin/env bash

#Set the CREATE_STUBS env variable to something to avoid delting the images

JXL_IIIF_FULL="full/full/0/default.jpg"

git submodule update --init --depth 1 -j 4 themes/*
for dir in `ls blogs/`;
do
  echo "Checking out submodule blogs/$dir"
  git submodule update --depth 1 -j 4 --init blogs/$dir
  rm -rf blogs/$dir/.git
  if [ -z "$CREATE_STUBS" ] ; then
    find blogs/$dir -type f -size +1M \( -name '*.jpg' -o -name '*.jxl' \) -print -exec rm {} \;
  else
  # Create image stubs
  for IMAGE in `find blogs/$dir -type f -size +1M \( -name '*.jpg' -o -name '*.jxl' \)`
  do
    IMAGE_SUFFIX=$(echo $IMAGE |awk -F . '{print $NF}')
    OUTPUT_DIR=`dirname $IMAGE`
    IIIF_DIR=`basename $IMAGE .$IMAGE_SUFFIX`
    TMP_IMAGE="$IMAGE-tmp.$IMAGE_SUFFIX"

    echo "Generating image stub from $IMAGE, temp file $TMP_IMAGE, extension $IMAGE_SUFFIX"

    convert $IMAGE -sampling-factor 4:2:0 -quality 1% front.jpg

    if [ $IMAGE_SUFFIX = "jxl" ] ; then
      mkdir -p `dirname "$OUTPUT_DIR/$JXL_IIIF_FULL"`
      convert $IMAGE -sampling-factor 4:2:0 -quality 1% "$IIIF_DIR/$JXL_IIIF_FULL"
    fi
    rm $IMAGE
    mv $TMP_IMAGE $IMAGE
  done
  fi
done
