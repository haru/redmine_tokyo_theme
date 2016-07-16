$(document).ready(function() {
    if (!$('#main-menu').length > 0) {
        $('#main').addClass('no-main-menu');
    }
    if ($('.mobile-toggle-button').css('display') != 'none') {
      $('#main').addClass('no-main-menu');
      $('body').addClass('mobile-mode');
    }
});
