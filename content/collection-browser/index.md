---
title: IIIF-Sammlungs-Browser
slug: collection-browser
params:
  displayinlist: false
  metaPage: true
  archive: false
  news: false
  sectionContent: false
---

# IIIF-Sammlungs-Browser

Der Inhalt von Projektemacher.org lässt sich auch als [IIIF-Sammlung](https://iiif.io/api/cookbook/recipe/0032-collection/) betrachten. Der Sammlungs-Browser nutzt den [Kasane](https://github.com/nakamura196/iiif-kasane)-Betrachter: Die Blogs und deren Bilder werden in der Struktur-Seitenleiste der Sammlung aufgelistet, ein Klick auf einen Eintrag öffnet ihn im Betrachter. Die Reihenfolge lässt sich zwischen 'wie aufgelistet' und 'nach Datum' umschalten.

{{< iiif/collection collectionUrl="https://projektemacher.org/collection.json" >}}
