document.observe('dom:loaded', function() {
    if ($('main-menu')) {
        return;
    }
    $('main').addClassName('no-main-menu');
});

