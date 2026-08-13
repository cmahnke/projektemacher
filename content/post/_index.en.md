---
url: posts
title: New posts
displayinlist: false
metaPage: true
layout: posts
cascade:
  - target:
      kind: '*'
      path: '**'
    params:
      sitemap:
        disable: true
  - target:
      kind: section
      path: '**'
      params:
        sitemap_exclude: true
        robotsdisallow: true
---
Current post from all blogs, external articles open in a new window.
