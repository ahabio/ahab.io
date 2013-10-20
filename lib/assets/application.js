(function($) {

  $(function() {
    var $search  = $('#page-header input[type=search]'),
        $results = $('#search-results'),
        $close   = $results.find('.close'),
        $main    = $('#main');

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

}(window.jQuery));
