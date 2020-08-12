Projektemacher
==============

# Using this repository

Make sure you check it out recursively, otherwise the theme and links to other blogs won't work.
Additionally you need to run `yarn` a least once if you want to start `hugo serve` for offline editing.

# Adding content

There are two content types:
* Post - for news
* Blog - for links to blogs - to be shown in a portfolio

## Options for all types

* `title` - Title for the content element
* `date` - Date of the content element
* `description` - Description of the content element

## Posts

Creating a new entry:
```
hugo new post/postnamehere/index.md
```

**Note:** Make sure to create the page bundle (option `-c`) in the right directory! Hugo seem to have some stupid defaults if working in a fake multisite tree.

### Options

## Blogs

Creating a new entry:
```
hugo new blog/blognamehere/index.md
```

### Options

* `lang` - List of available languages
* `link` - Link to blogs
* `linkPrefix` - Prefix for links to this blog
* `status` - One of `active`, `inactive` or `planned`

### Creating a new empty screenshot

```
convert -size 1024x768 -background gray36 -gravity Center -fill gray93 -font ./static/fonts/Lato-Bold.ttf label:"TEXT" screenshot.png
```

## Adding Blogs for inclusion in news

Add the blog as Git submodule:

```
git submodule add https://github.com/cmahnke/kraehenbeisser.git blogs/kraehenbeisser
```

Edit `config.toml`:

```
    [[module.mounts]]
        source = "blogs/kraehenbeisser/content/post"
        target = "content/post/kraehenbeisser"
```

Make sure there is a page in `contents/blog` for the newly added blog since some metadata is pulled from there.

# Debugging `static` mounts

```
/usr/local/bin/hugo server -D --debug --disableFastRender --renderToDisk
```
