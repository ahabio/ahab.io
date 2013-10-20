(function($, Handlebars) {

  $(function() {
    var LIMIT       = 40,
        $search     = $('#page-header input[type=search]'),
        $results    = $('#search-results'),
        $main       = $('#main'),
        tplHtml     = $('#search-results-tpl').html(),
        tpl         = Handlebars.compile(tplHtml),
        currOffset  = 0,
        totalAssets = 0,
        currLimit   = LIMIT;

    Handlebars.registerHelper('searchHeader', function(context, options) {
      var html = 'DISPLAYING '+Math.max(1, currOffset)+' - '+Math.min(totalAssets, (currOffset+currLimit))+' OF '+totalAssets+' ASSET RESULTS';
      if (!totalAssets) html = 'NO ASSETS FOUND';
      return new Handlebars.SafeString('<h5>' + html + '</h5>');
    });

    Handlebars.registerHelper('searchFooter', function(context, options) {
      var start = currOffset + currLimit,
          end   = start + currLimit;
      if (end > totalAssets) end = totalAssets;
      if (totalAssets <= currLimit) return '';
      return new Handlebars.SafeString('<a href="#">DISPLAY '+start+' - '+end+' OF '+totalAssets+' ASSET RESULTS...</a>');
    });

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
      totalAssets = res.length;
      $results.html(tpl({
        results:     res,
        totalAssets: totalAssets
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
      if ($search.val().length < 2) {
        return showSearchResults(false);
      }
      $.getJSON('/search.json', getSearchOptions())
        .always(showSearchResults.bind(showSearchResults, true))
        .done(renderSearchResults.bind(renderSearchResults));
    });

    $results.on('click', '.close', showSearchResults.bind(showSearchResults, false));
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

  $(function() {
    var $register = $("#register-assets");
    $(".publish").click(function() {
      $register.dialog({
        position: {my: "top", at: "top+80", of: window},
        width: 'auto',
        modal: true
      });
    });
    $('#close_modal').on("click", function() {
      //Close the dialog
      $register.dialog("close");
    });
  });

}(window.jQuery, window.Handlebars));
