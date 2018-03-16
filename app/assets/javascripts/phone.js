$(document).ready(function () {
    var phone = $('.marvel-device');

    function setPhoneOrientation() {
        var windowWidth = $(window).width();
        if (windowWidth < 1200 && windowWidth > 767) {
            phone.addClass('landscape');
        } else {
            phone.removeClass('landscape');
        }
    }

    setPhoneOrientation();

    $(window).resize(function () {
        setTimeout(function () {
            setPhoneOrientation();
        }, 100);
    });
});
