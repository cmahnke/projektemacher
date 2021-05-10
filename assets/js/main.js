window.$ = window.jQuery = require('jquery');
const Fuse = require('fuse.js')
//require('bootstrap');
import 'bootstrap';

// This hack is needed to get the shared index definition
const definition = require('./index-definition.js');
const options = definition.options;

const searchIndex = '/search-index.json';
var idx;

function loadIndex() {
    $.ajax({
        //async: false,
        url: searchIndex,
        type: 'get',
        dataType: 'json'
    })
    .done(function(response) {
        idx = new Fuse(response.docs, options, Fuse.parseIndex(response.index))
    });
}

function searchPosts (query) {
    if (idx !== undefined) {
        const results = idx.search(query)
        return results;
    }
    return null;
}

function doSearch(str, elem, heading) {
    results = searchPosts(str).reverse();
    console.log(results);

    var html = '';
    if (heading !== undefined && heading !== '' ) {
        html = '<div class="query">' + heading + ' "' + str + '"</div>';
    }
    html += '<ul class="search-result-list">';

    html += results.map(
        (hit) => `
            <li class="search-result-item" data-score="${hit.score.toFixed(2)}">
              <a href="${hit.item.url}" class="search-result-page-title">${hit.item.title}</a><span class="date"></span>
              <p class="search-preview">${hit.item.content.substr(0, 150)}...</p>
            </li>`
      ).join("");
    html += '</ul>';
    $(elem).html(html);

}

window.loadIndex = loadIndex;
window.searchPosts = searchPosts;
window.doSearch = doSearch;
