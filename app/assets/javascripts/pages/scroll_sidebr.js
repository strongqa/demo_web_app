$(document).ready(function () {
    var $window = $(window);
    var floatingElement = $('.floating');
    var NexToFloatingElement = $(floatingElement.data('next'));
    var prevToFloatingElement = $(floatingElement.data('prev'));
    var elementOffset = floatingElement.data('element-offset');

    function floatingSidebar() {
        floatingElement.css('width', floatingElement.parent().width());
        if ($window.width() > 1199) {
            floatingElement.affix({
                offset: {
                    top: ($(prevToFloatingElement).offset().top + $(prevToFloatingElement).outerHeight()) - elementOffset,
                    bottom: NexToFloatingElement.outerHeight(true)
                }
            });
        } else {
            floatingElement.removeClass('affix affix-top affix-bottom');
        }
    }

    floatingSidebar();

    $window.resize(function () {
        setTimeout(function () {
            floatingSidebar();
        }, 100);
    });
});
