#!/usr/bin/env bash

# Fixes the languages of the checked out blogs.
# The content of the blogs is mounted into this site, which has a default
# content language of 'de'. Blogs with a different default content language
# get their page and section files renamed, so the default language files
# match the default language of this site.

set -e

PARENT_LANG=$(grep -iE '^defaultcontentlanguage[[:space:]]*=' hugo.toml | head -1 | sed -E 's/.*=[[:space:]]*"?([A-Za-z-]+)"?.*/\1/')

if [ -z "$PARENT_LANG" ] ; then
  echo "No 'defaultContentLanguage' found in 'hugo.toml'"
  exit 1
fi

echo "Default language of this site: $PARENT_LANG"

for BLOG in blogs/*/ ;
do
  CONFIG=$(find "$BLOG" -maxdepth 1 \( -name 'hugo.toml' -o -name 'config.toml' \) | head -1)
  if [ -z "$CONFIG" ] ; then
    echo "No configuration found for '$BLOG', skipping"
    continue
  fi

  BLOG_LANG=$(grep -iE '^defaultcontentlanguage[[:space:]]*=' "$CONFIG" | head -1 | sed -E 's/.*=[[:space:]]*"?([A-Za-z-]+)"?.*/\1/')
  if [ -z "$BLOG_LANG" ] ; then
    BLOG_LANG="en"
  fi

  if [ "$BLOG_LANG" = "$PARENT_LANG" ] ; then
    continue
  fi

  if [ ! -d "$BLOG/content" ] ; then
    continue
  fi

  echo "Blog '$BLOG' has default language '$BLOG_LANG', fixing files"

  find "$BLOG/content" \( -name 'index.md' -o -name '_index.md' \) -print0 | while IFS= read -r -d '' FILE ; do
    DIR=$(dirname "$FILE")
    BASE=$(basename "$FILE" .md)
    PARENT_FILE="$DIR/$BASE.$PARENT_LANG.md"
    BLOG_FILE="$DIR/$BASE.$BLOG_LANG.md"

    if [ -f "$PARENT_FILE" ] ; then
      if [ -f "$BLOG_FILE" ] ; then
        echo "Warning: '$BLOG_FILE' already exists, skipping '$DIR'"
        continue
      fi
      mv "$FILE" "$BLOG_FILE"
      mv "$PARENT_FILE" "$FILE"
      echo "Swapped: '$FILE' <-> '$PARENT_FILE'"
    elif [ -f "$BLOG_FILE" ] ; then
      echo "Warning: conflicting language files in '$DIR', skipping (fix at source)"
    else
      mv "$FILE" "$BLOG_FILE"
      echo "Renamed: '$FILE' -> '$BLOG_FILE'"
    fi
  done
done
