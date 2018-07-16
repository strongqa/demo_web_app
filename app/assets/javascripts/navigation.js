$(document).ready(function() {
    function setMenuHeight() {
        var navWrapper = $('.navigation__wrapper');
        if ($(window).width() < 992) {
            var navHeight = $('.navigation').height();
            navWrapper.css('height', window.innerHeight - navHeight).css('top', navHeight);
        } else {
            navWrapper.css('height', 'auto').css('top', 'auto');
        }
    }

    $('.navigation__button').click(function() {
        $('body').toggleClass('closed opened');
        setMenuHeight();
    });

    $(window).resize(function () {
        setTimeout(function () {
            setMenuHeight();
        }, 300);
    });
});
