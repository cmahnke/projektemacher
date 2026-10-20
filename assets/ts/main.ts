import jQuery from 'jquery';
import Fuse from 'fuse.js';
import 'bootstrap';
// Resolved from the theme's assets (ts/iiif-image-viewer.ts) via Hugo's merged assets FS at build time
// @ts-expect-error Not visible to tsc - the theme is a separate module
import './iiif-image-viewer';
import { options } from './index-definition';
import type { SearchDoc } from './index-definition';
import type { FuseResult, FuseIndex } from 'fuse.js';

declare global {
  interface Window {
    $: typeof jQuery;
    jQuery: typeof jQuery;
    loadIndex(): void;
    searchPosts(query: string): FuseResult<SearchDoc>[] | null;
    doSearch(str: string, elem: string | HTMLElement, heading?: string): void;
  }
}

window.$ = window.jQuery = jQuery;

const searchIndex = '/search-index.json';

let idx: Fuse<SearchDoc> | undefined;

function loadIndex(): void {
  jQuery.ajax({
    //async: false,
    url: searchIndex,
    type: 'get',
    dataType: 'json'
  })
    .done(function (response: { docs: SearchDoc[]; index: FuseIndex<SearchDoc> }) {
      idx = new Fuse(response.docs, options, Fuse.parseIndex<SearchDoc>(response.index));
    });
}

function searchPosts(query: string): FuseResult<SearchDoc>[] | null {
  if (idx !== undefined) {
    return idx.search(query);
  }
  return null;
}

function doSearch(str: string, elem: string | HTMLElement, heading?: string): void {
  const results = searchPosts(str)?.reverse() ?? [];
  console.log(results);

  let html = '';
  if (heading !== undefined && heading !== '') {
    html = '<div class="query">' + results.length + ' ' + heading + ' "' + str + '"</div>';
  }
  html += '<ul class="search-result-list">';

  html += results.map(
    (hit) => `
        <li class="search-result-item" data-score="${hit.score?.toFixed(2)}">
          <a href="${hit.item.url}" class="search-result-page-title">${hit.item.title}</a><span class="date"></span>
          <p class="search-preview">${hit.item.content.substr(0, 150)}...</p>
        </li>`
  ).join('');
  html += '</ul>';
  const target = typeof elem === 'string' ? jQuery(elem) : jQuery(elem);
  target.html(html);

}

window.loadIndex = loadIndex;
window.searchPosts = searchPosts;
window.doSearch = doSearch;
