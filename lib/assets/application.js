(function($) {

  $(function() {
    var $search  = $('input.search'),
        $close   = $('.search-top .close'),
        $main    = $('.main'),
        $results = $('#search-results');

    var showSearchResults = function(show) {
      if (show) {
        $main.hide();
        $results.show();
      } else {
        $main.show();
        $results.hide();
      }
      return show;
    };

    $search.on('search', function(evt) {
      $.getJSON('/search.json', { q: $search.val() })
        .always(showSearchResults.bind(showSearchResults, true))
        .done(function(res) {
          // Render some UI!
        });
    });

    $close.on('click', showSearchResults.bind(showSearchResults, false));
  });

}(window.jQuery));
