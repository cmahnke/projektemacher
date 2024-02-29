#!/bin/sh

CTX_PATH="$(dirname $(realpath $0))"

$CTX_PATH/../themes/projektemacher-base/scripts/github/setup-dependencies.sh
#$CTX_PATH/../themes/projektemacher-base/scripts/github/setup-yarn.sh
$CTX_PATH/../themes/projektemacher-base/scripts/github/docker-images.sh
$CTX_PATH/../themes/projektemacher-base/scripts/github/dart-sass.sh
