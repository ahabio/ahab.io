(function($, Handlebars) {

  $(function() {
    var LIMIT       = 40,
        $search     = $('#page-header input[type=search]'),
        $results    = $('#search-results'),
        $searchBody = $results.find('.search-body'),
        $close      = $results.find('.close'),
        $main       = $('#main'),
        tplHtml     = $('#search-results-tpl').html(),
        tpl         = Handlebars.compile(tplHtml),
        currOffset  = 0,
        currLimit   = LIMIT;

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

    var renderSearchResults = function(res) {
      $searchBody.html(tpl({
        results: res
      }));
    };

    var getSearchOptions = function(limit, offset) {
      return {
        q:      $search.val(),
        limit:  limit || currLimit,
        offset: offset || currOffset
      };
    };

    $search.on('search', function(evt) {
      $.getJSON('/search.json', getSearchOptions())
        .always(showSearchResults.bind(showSearchResults, true))
        .done(renderSearchResults.bind(renderSearchResults));
    });

    $close.on('click', showSearchResults.bind(showSearchResults, false));
  });

}(window.jQuery, window.Handlebars));
