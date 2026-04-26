$(document).ready(function() {
    if (!$('#main-menu').length > 0) {
        $('#main').addClass('no-main-menu');
    }
    if ($('.mobile-toggle-button').css('display') != 'none') {
      $('#main').addClass('no-main-menu');
      $('body').addClass('mobile-mode');
    }

    var h1 = $('#header h1');
    if (h1.length > 0 && h1.find('.current-project').length === 0) {
        h1.wrapInner('<span class="current-project"></span>');
    }
});
