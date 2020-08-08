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

### Options

## Blogs

Creating a new entry:
```
hugo new blog/blognamehere/index.md
```

### Options

* `planned` - For blogs not available yet - boolean
* `lang` - List of available languages
* `link` - Link to blogs
* `status` - Either `active` or `inactive`
