(function($) {

  $(function() {
    var $search = $('input.search');
    $search.on('search', function(evt) {
      console.log($search.val());
    });
  });

}(window.jQuery));
