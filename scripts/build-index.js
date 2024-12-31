//const glob = require('glob')
const fg = require('fast-glob');
const fs = require('fs');
const Fuse = require('fuse.js')

var siteDir = './docs';
var indexFile = siteDir + '/search-index.json';
var docsFile = siteDir + '/docs.json';

// This hack is needed to get the shared index definition
const definition = require('../assets/js/index-definition.js');
const options = definition.options;

//glob(siteDir + '/**/index.json', function(err, res) {

fg([`${siteDir}/**/index.json`]).then((res) => {
    //if (err) {
    //    console.log('Error', err);
    //} else {
        console.log('Found ' + res + ', indexing');
        docs = [];
        res.forEach(function(file) {
            console.log('Found ' + file + ', indexing');
            try {
              docs.push(JSON.parse(fs.readFileSync(file, 'utf8')))
            } catch (e) {
              console.warn(`Failed to index ${file}`, e)
            }
        });

    //}
    const index = Fuse.createIndex(options.keys, docs, )
    console.log('Writing ' + docs.length + ' entries to ' + indexFile);
    fs.writeFileSync(indexFile, JSON.stringify({'docs': docs, 'index': index.toJSON()}), 'utf8');

});
