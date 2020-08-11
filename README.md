Projektemacher
==============

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

Make sure to create the page bundle in the right directory!


### Options

## Blogs

Creating a new entry:
```
    hugo new blog/blognamehere/index.md
```

### Options

* `lang` - List of available languages
* `link` - Link to blogs
* `status` - One of `active`, `inactive` or `planned`

### Creating a new empty screenshot

```
convert -size 1024x768 -background gray36 -gravity Center -fill gray93 -font ./static/fonts/Lato-Bold.ttf label:"TEXT" screenshot.png
```

## Adding Blogs for inclusion in news

Add the blog as Git submodule:

```
cd blogs
git submodule add https://github.com/cmahnke/kraehenbeisser.git
```

Edit `config.toml`:

```
    [[module.mounts]]
        source = "blogs/kraehenbeisser/content/post"
        target = "content/post/kraehenbeisser"
```

# Debugging mounts

```
/usr/local/bin/hugo server -D --debug --disableFastRender --renderToDisk
```
