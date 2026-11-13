---
title: IIIF collection browser
slug: collection-browser
params:
  displayinlist: false
  metaPage: true
  archive: false
  news: false
  sectionContent: false
---

# IIIF collection browser

The content of Projektemacher.org is also available as a [IIIF collection](https://iiif.io/api/cookbook/recipe/0032-collection/). The collection browser uses the [Kasane](https://github.com/nakamura196/iiif-kasane) viewer: the blogs and their images are browsed in the structure side panel of the collection; clicking an entry opens it in the viewer. The ordering can be switched between 'as listed' and 'by date'.

{{< iiif/collection collectionUrl="https://projektemacher.org/collection.json" >}}
