---
outputs:
  - iiif-collection
  - html
  - rss
cascade:
  - _target:
      kind: 'page'
      path: '/privacy'
      lang: '*'
    params:
      sitemap:
        disable: true
  - _target:
      kind: 'page'
      lang: '*'
      path: 'privacy'
    params:
      sitemap:
        disable: true
---
