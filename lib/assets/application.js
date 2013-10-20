(function($, Handlebars) {

  $(function() {
    var $search     = $('#page-header input[type=search]'),
        $results    = $('#search-results'),
        $searchBody = $results.find('.search-body'),
        $close      = $results.find('.close'),
        $main       = $('#main'),
        tplHtml     = $('#search-results-tpl').html(),
        tpl         = Handlebars.compile(tplHtml);

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
          $searchBody.html(tpl({
            results: res
          }));
        });
    });

    $close.on('click', showSearchResults.bind(showSearchResults, false));
  });

}(window.jQuery, window.Handlebars));
