const glob = require('glob')
const fs = require('fs');
var lunr = require('lunr');

var siteDir = 'docs';
var indexFile = siteDir + '/search-index.json';

var index;

glob(siteDir + '/**/index.json', function (err, res) {
  if (err) {
    console.log('Error', err);
  } else {
    index = lunr(function () {
        this.ref('url')
        this.field('date')
        this.field('description')
        this.field('title')
        this.field('content')

        res.forEach(function (file) {
            console.log('Found ' + file + ', indexing');
            this.add(JSON.parse(fs.readFileSync(file, 'utf8')))
        }, this)

    });
    console.log('Writing ' + indexFile);
    fs.writeFileSync(indexFile, JSON.stringify(index), 'utf8');

  }
});
