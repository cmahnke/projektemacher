window.$ = window.jQuery = require('jquery');

//require('bootstrap');
import 'bootstrap';
import 'lunr';

var index;

function loadIndex() {
    var index;
    $.ajax({
       url: '/search-index.json',
       type: 'get',
       beforeSend: function (){
           $("#search-bar").disable();
       },
       success: function (response){
           index = lunr.Index.load(response.json);
       },
       complete:function (data){
           $("#search-bar").enable();
       }
     });
     return index;
}


$('#search-toggle').on('change', function () {
    if (index === undefined) {
        index = loadIndex();
    }
});
