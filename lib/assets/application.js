(function($) {

  $(function() {
    var $search   = $('input.search'),
        $close    = $('.search-top .close'),
        $hero     = $('div.hero'),
        $audience = $('section.target-audience'),
        $results  = $('div.search-results');

    var showSearchResults = function(show) {
      if (show) {
        $hero.hide();
        $audience.hide();
        $results.show();
      } else {
        $hero.show();
        $audience.show();
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
