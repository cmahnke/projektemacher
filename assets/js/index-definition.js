const options = {
    // isCaseSensitive: false,
    includeScore: true,
    shouldSort: true,
    includeMatches: true,
    // findAllMatches: false,
    minMatchCharLength: 3,
    // location: 0,
    threshold: 0.6,
    // distance: 100,
    // useExtendedSearch: false,
    // ignoreLocation: false,
    // ignoreFieldNorm: false,
    keys: [
        'date', 'title', 'url', 'content', 'tags', 'description', 'displayDate'
    ]
};

exports.options = options;
