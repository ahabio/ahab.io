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

  $(function buildDocumentationTOC() {
    function linkify($h, $toc) {
      var tagName = $h[0].tagName,
          text = $h.text(),
          id = $h.text().replace(/[^a-zA-Z0-9_]/g, '-');
      $h.attr('id', id);
      $toc.append("<a href='#" + id + "' class='" + tagName + "'>" + text + "</a>");
    }

    var $documentation = $('.documentation'),
        $toc           = $documentation.find('.docs-links');

    $documentation.find('h2,h3').each(function(i, h) {
      linkify($(h), $toc);
    });

    $toc.show();
  });

}(window.jQuery, window.Handlebars));
