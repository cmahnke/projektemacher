#!/usr/bin/env bash

# Compares the blogs of this site with the head of their remote 'main' branch
# and warns when a blog is not recorded at the remote head, i.e. the parent
# repository needs an update ('./scripts/update-blogs.sh').
# Set FAIL_ON_DRIFT to something to exit with an error when a blog is behind.

set -e

DRIFT=0

for SUBMODULE in $(git config --file .gitmodules --get-regexp '\.path$' | awk '{print $2}') ; do
  case "$SUBMODULE" in
    blogs/*) ;;
    *) continue ;;
  esac
  URL=$(git config --file .gitmodules --get "submodule.$SUBMODULE.url")
  RECORDED=$(git ls-tree HEAD "$SUBMODULE" | awk '{print $3}')
  REMOTE=$(git ls-remote "$URL" refs/heads/main 2>/dev/null | awk '{print $1}')
  if [ -z "$REMOTE" ] ; then
    echo "Warning: could not determine remote head of '$URL'"
    continue
  fi
  if [ "$RECORDED" != "$REMOTE" ] ; then
    echo "Warning: '$SUBMODULE' is not at the head of 'main' (recorded: $RECORDED, remote: $REMOTE)"
    DRIFT=$((DRIFT+1))
  else
    echo "OK: '$SUBMODULE'"
  fi
done

if [ "$DRIFT" -gt 0 ] ; then
  echo "$DRIFT blog(s) not at the head of 'main', run './scripts/update-blogs.sh' and commit the new submodules"
  if [ -n "$FAIL_ON_DRIFT" ] ; then
    exit 1
  fi
fi
