$(document).ready(function(){

    function setMenuHeight() {
        var navHeight = $('.navigation').height();
        $('.navigation__wrapper')
            .css('height', $(window).height() - navHeight)
            .css('top', navHeight);
    }

    $('.navigation__button').click(function(){
        $('body').toggleClass('closed opened');
        setMenuHeight();
    });

    $(window).resize(function () {
        setTimeout(function () {
            setMenuHeight();
        }, 300);
    });

});
